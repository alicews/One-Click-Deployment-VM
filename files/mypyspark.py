from pyspark.sql import functions as F
from pyspark.sql import DataFrameNaFunctions as DFna
from pyspark.sql.functions import udf, col, when
import pyspark as ps
import os, sys, json


spark = ps.sql.SparkSession.builder \
            .master("local[4]") \
            .appName("building recommender") \
            .getOrCreate() # create a spark session
            
sc = spark.sparkContext # create a spark context


ratings_df = spark.read.csv('s3://movielens-alice/ml-latest-small/ratings.csv',
                         header=True,       # use headers or not
                         quote='"',         # char for quotes
                         sep=",",           # char for separation
                         inferSchema=True)  # do we infer schema or not ?
# ratings_df.printSchema()

ratings = ratings_df.rdd
numRatings = ratings.count()
numUsers = ratings.map(lambda r: r[0]).distinct().count()
numMovies = ratings.map(lambda r: r[1]).distinct().count()


from pyspark.ml.evaluation import RegressionEvaluator
from pyspark.ml.recommendation import ALS
from pyspark.ml.tuning import CrossValidator, ParamGridBuilder
from pyspark.ml import Pipeline
from pyspark.sql import Row
import numpy as np
import math


iterations = 10
regularization_parameter = 0.1
ranks = range(4, 12)
errors = []
err = 0
tolerance = 0.02
min_error = float('inf')
best_rank = -1
best_iteration = -1

training_df, validation_df, test_df = ratings_df.randomSplit([.6, .2, .2], seed=42)

for rank in ranks:
    als = ALS(maxIter=iterations, regParam=regularization_parameter, rank=rank, userCol="userId", itemCol="movieId", ratingCol="rating")
    model = als.fit(training_df)
    predictions = model.transform(validation_df)
    new_predictions = predictions.filter(col('prediction') != np.nan)
    evaluator = RegressionEvaluator(metricName="rmse", labelCol="rating", predictionCol="prediction")
    rmse = evaluator.evaluate(new_predictions)
    errors.append(rmse)

    print('For rank %s the RMSE is %s' % (rank, rmse))
    if rmse < min_error:
        min_error = rmse
        best_rank = rank
print('The best model was trained with rank %s' % best_rank)


final_als = ALS(maxIter=iterations, regParam=regularization_parameter, rank=best_rank, userCol="userId", itemCol="movieId", ratingCol="rating")
final_model = final_als.fit(ratings_df)

final_model.save('s3://movielens-alice/ml-latest-small/mymodel')

# from pyspark.mllib.recommendation import ALS, MatrixFactorizationModel, Rating
# sameModel = MatrixFactorizationModel.load(sc, 's3://movielens-alice/ml-latest-small/mymodel')