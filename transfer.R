#!/usr/bin/env Rscript
library(jsonlite)

cfg_str <- '{ "S3": { "aws_access_key_id" : "AKIAI453NO9OXEHEAKMA", "aws_secret_access_key": "oam/eivie9Ahkur6pohb4_iquos6iet0zeivo+6S", "bucket": "prdetl2023" }}'

cfg <- fromJSON(cfg_str)

head(cfg)
