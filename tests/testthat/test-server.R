test_that("covid_filter", {
  expect_output(covid_filter(covid, stats = "weekly"), "Invalid value passed to stats argument. Please enter 'cumulative' or 'daily'.")
})
