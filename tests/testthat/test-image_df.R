test_that("Data is installed", {

  if ("sri24" %in% installed.packages()[, "Package"]) {
    expect_is(sri24_image_df(), "data.frame")
  } else {
    expect_is(sri24_image_df(), "NULL")
  }
})
