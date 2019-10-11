#' Create a function to convert CAMERA output to edge list file
#' 
#' @param peaklist Output of `getPeaklist` function from `CAMERA` package.
#' @example 
#' getEdgelist(getPeaklist(xsaFA))

getEdgelist <- function(peaklist){
  pl <- split(peaklist, peaklist$pcgroup)
  
  edges = data.frame(do.call(rbind, (lapply(pl, .process_pcgroup))))
  return(edges)
}

.define_annot <- function(y){
  if(any(y$adduct == "")) return(NA)
  if(unlist(strsplit(y$adduct[1], ' ') )[2] == 
     unlist(strsplit(y$adduct[2], ' ') )[2]) {
    a = paste(do.call(rbind, (strsplit(y$adduct, ' ') ))[,1], collapse = " ")
    paste(a, "dm/z=", round(abs(y$mz[1] - y$mz[2]), 4))
  } else NA
}

.define_isotop <- function(w){
  if(any(w$isotopes == "")) return(NA)
  if(unlist(strsplit(w$isotopes[1], '\\]\\[') )[1] == 
     unlist(strsplit(w$isotopes[2], '\\]\\[') )[1]) {
    a = paste0("[", do.call(rbind, strsplit(w$isotopes, "\\]\\["))[,2], 
               collapse = " ")
    b = paste0(unlist(strsplit(w$isotopes[2], '\\]') )[1], "]")
    paste(b, a, "dm/z=", round(abs(w$mz[1] - w$mz[2]), 4))
  } else NA
}

.process_pcgroup <- function(x){
  res <- combn(1:nrow(x), 2, FUN = function(z) {
    ## do something with the pairs
    list(ID1 = rownames(x)[z[1]],
         ID2 =  rownames(x)[z[2]],
         EdgeType = "MS1 annotation",
         Score = NA,
         Isotop = .define_isotop(x[z,]),
         Annotation = .define_annot(x[z,]),
         pcgroup = x$pcgroup[1])
  },simplify = FALSE)
  do.call(rbind, res)
}
