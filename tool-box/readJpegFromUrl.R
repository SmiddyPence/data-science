readJpegFromUrl <- function (url) {
  z <- tempfile()
  download.file(url,z,mode="wb")
  pic <- readJPEG(z, native = TRUE)
  file.remove(z) 
  pic
}
