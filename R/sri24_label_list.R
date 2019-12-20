
#' SRI24 Label Look Up Tables (LUT)
#'
#' @param label The specific label LUT to read in
#'
#' @return A list of \code{data.frame}s or a specific \code{data.frame}
#' @export
#' @importFrom grDevices rgb
#'
#' @examples
#' sri24_label_list()
#' sri24_label_df()
#' sri24_label_df("LPBA40")
#' sri24_label_colors("LPBA40")
#' sri24_label_file()
#' @importFrom utils read.table
sri24_label_list = function() {
  lab_file = system.file("extdata", "SRI24-tzo116plus.txt", package = "sri24")
  lab_file = readLines(lab_file)
  lab_file = gsub(" \\s+", " ", lab_file)
  lab_file = gsub(" ", "\t", lab_file)
  tfile = tempfile(fileext = ".txt")
  writeLines(lab_file, tfile)
  tab = read.table(file = tfile, header = FALSE, as.is = TRUE)
  colnames(tab) = c("index", "label", "R", "G", "B", "A")
  tab$color = rgb(tab$R, tab$G, tab$B, tab$A, maxColorValue = 255)
  L = list()
  L$`TZO` = tab

  lab_file = system.file("extdata", "LPBA40-labels.txt", package = "sri24")
  lab_file = readLines(lab_file)
  lab_file = gsub(" \\s+", " ", lab_file)
  lab_file = gsub(" ", "\t", lab_file)
  tfile = tempfile(fileext = ".txt")
  writeLines(lab_file, tfile)
  tab = read.table(file = tfile, header = FALSE, as.is = TRUE)
  colnames(tab) = c("index", "label", "R", "G", "B", "A")
  tab$color = rgb(tab$R, tab$G, tab$B, tab$A, maxColorValue = 255)

  L$`LPBA40` = tab

  return(L)
}


#' @rdname sri24_label_list
#' @export
sri24_label_df = function(label = c("TZO", "LPBA40")) {
  label = match.arg(label)
  L = sri24_label_list()
  L[[label]]
}

#' @rdname sri24_label_list
#' @export
sri24_label_colors = function(label = c("TZO", "LPBA40")) {
  tab = sri24_label_df(label)
  tab$color
}


#' @rdname sri24_label_list
#' @export
sri24_label_file = function(label = c("TZO", "LPBA40")) {
  df = sri24::sri24_image_df()
  label = match.arg(label)
  rn = switch(label,
              TZO = "tzo116plus",
              "LPBA40" = "lpba40")
  fname = df[rn, ]$file
  fname
}

