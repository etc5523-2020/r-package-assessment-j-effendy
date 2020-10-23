test_that("daterange", {
  expect_error(daterange("id", start = "2020-05-01", end = "2020-04-01"))
  expect_error(daterange("", start = "2020-03-01", end = "2020-04-01"))
  expect_error(daterange("id", start = "2020-02-01", end = "2020-04-01"))
  expect_error(daterange("id", start = "2020-05-01", end = "2020-11-01"))
  expect_error(daterange(start = "2020-05-01", end = "2020-04-01"))
})
