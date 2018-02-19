#' SRI24 Images
#'
#' @return A \code{data.frame} for \code{sri24_image_df} and a
#' character vector for \code{sri24_images}
#' @export
#'
#' @examples
#' library(neurobase)
#' sri24_image_df()
#' imgs = sri24_images()
#' imgs
#' imgs["erly"]
#' img = readnii(imgs["erly"])
#' ortho2(img)
#'
#'
sri24_image_df = function() {
  stubs = c("erly_unstrip", "erly", "fa", "l1", "late_unstrip", "late",
           "lpba40", "lt", "md", "pbmap_CSF", "pbmap_GM", "pbmap_WM",
           "spgr_unstrip",
           "spgr", "suptent", "tissues", "tzo116plus")
  imgs = paste0(stubs, ".nii.gz")
  names(imgs) = stubs
  imgs = sapply(imgs, function(x) {
    system.file("extdata", x, package = "sri24")
  })
  imgs = imgs[ imgs != "" ]
  if (length(imgs) == 0) {
    return(NULL)
  }
  imgs = data.frame(file = imgs,
                    stub = names(imgs), stringsAsFactors = FALSE)
  anat = c("erly_unstrip", "late_unstrip", "spgr_unstrip")
  anat = c(anat, sub("_unstrip", "", anat))
  dti = c("lt", "md", "fa", "l1")
  labels = c("tzo116plus", "lpba40", "suptent")
  tissues = c("tissues", "pbmap_CSF", "pbmap_WM", "pbmap_GM")

  imgs$type = NA
  imgs$type[ imgs$stub %in% anat] = "anat"
  imgs$type[ imgs$stub %in% dti] = "dti"
  imgs$type[ imgs$stub %in% labels] = "label"
  imgs$type[ imgs$stub %in% tissues] = "tissue"

  return(imgs)
}

#' @rdname sri24_image_df
#' @export
sri24_images = function() {
  df = sri24_image_df()
  files = df$file
  names(files) = df$stub
  files
}

