#' @title Convert CAMERA output to an edge list for GNPS
#'
#' @description
#'
#' `getEdgelist` takes the output from the `getPeaklist` function from `CAMERA`
#' and converts it to a `data.frame` with edge definitions for *GNPS*. Each
#' row in that `data.frame` contains in columns `"ID1"` and `"ID2"` the
#' identifiers (i.e. `rownames` of the input `data.frame`) of the features.
#' Column `"EdgeType"` is always `"MS1 annotation"` and column `"Score"` `NA`
#' (since no score can be exported from `CAMERA`). Columns `"Annotation"`
#' contains the adduct names and their difference in m/z if **both** edges
#' (features) were predicted to be an adduct of the **same** compound.
#' Column `"Isotope"` provides the same information as for adducts, only for
#' isotope definitions. Column `"pcgroup"` provides the information which
#' features were grouped by `CAMERA` into the same group.
#' 
#' @param peaklist `data.frame` as returned by the [getPeaklist()] function
#'   from `CAMERA` package or an `xsAnnotate` object.
#'
#' @return `data.frame` with edge definitions (see description for more
#'     details).
#'
#' @author Mar Garcia-Aloy, Johannes Rainer
#' 
#' @examples
#' 
#' res <- getEdgelist(getPeaklist(xsaFA))
getEdgelist <- function(peaklist) {
    if (is(peaklist, "xsAnnotate")) {
        peaklist <- getPeaklist(peaklist)
        if (!nrow(peaklist))
            stop("Got an empty peak list.")
    }
    pl <- split(peaklist, factor(peaklist$pcgroup,
                                 levels = unique(peaklist$pcgroup)))
    res <- do.call(rbind, lapply(pl, .process_pcgroup))
    rownames(res) <- NULL
    res
}

#' Helper function to extract the adduct annotation from a pair of adducts
#' from the same *pcgroup*.
#'
#' @author Mar Garcia-Aloy
#'
#' @noRd
.define_annot <- function(y) {
    if (any(y$adduct == "")) return(NA)
    mass_1 <- .extract_mass_adduct(y$adduct[1])
    mass_2 <- .extract_mass_adduct(y$adduct[2])
    mass <- intersect(mass_1, mass_2)
    if (length(mass)) {
        def1 <- unlist(strsplit(y$adduct[1], " "))
        def2 <- unlist(strsplit(y$adduct[2], " "))
        paste0(def1[grep(mass[1], def1) - 1], " ",
               def2[grep(mass[1], def2) - 1], " dm/z=",
               round(abs(y$mz[1] - y$mz[2]), 4))
    } else NA
}

#' Helper function to extract the isotope annotation from a pair of adducts
#' from the same *pcgroup*.
#'
#' @author Mar Garcia-Aloy
#'
#' @noRd
.define_isotop <- function(w) {
  if (any(w$isotopes == "")) return(NA)
  if (unlist(strsplit(w$isotopes[1], '\\]\\[') )[1] == 
     unlist(strsplit(w$isotopes[2], '\\]\\[') )[1]) {
    a = paste0("[", do.call(rbind, strsplit(w$isotopes, "\\]\\["))[, 2], 
               collapse = " ")
    b = paste0(unlist(strsplit(w$isotopes[2], '\\]') )[1], "]")
    paste0(b, a, " dm/z=", round(abs(w$mz[1] - w$mz[2]), 4))
  } else NA
}

#' Simple helper to extract the mass(es) from strings such as
#' [M+NH4]+ 70.9681 [M+H]+ 87.9886
#'
#' @author Johannes Rainer
#' 
#' @noRd
#' 
#' @examples
#'
#' .extract_mass_adduct("[M+NH4]+ 70.9681 [M+H]+ 87.9886")
#' .extract_mass_adduct("some 4")
.extract_mass_adduct <- function(x) {
    if (!length(x) || x == "") return(NA)
    spl <- unlist(strsplit(x, " ", fixed = TRUE))
    spl[seq(2, by = 2, length.out = length(spl)/2)]
}

#' Helper function to process features from the same *pcgroup*
#'
#' @author Mar Garcia-Aloy
#'
#' @noRd
.process_pcgroup <- function(x) {
    if (nrow(x) > 1) {
        res <- combn(seq_len(nrow(x)), 2, FUN = function(z) {
            data.frame(ID1 = rownames(x)[z[1]],
                       ID2 =  rownames(x)[z[2]],
                       EdgeType = "MS1 annotation",
                       Score = NA,
                       Annotation = .define_annot(x[z,]),
                       Isotope = .define_isotop(x[z,]),
                       pcgroup = x$pcgroup[1],
                   stringsAsFactors = FALSE)
        }, simplify = FALSE)
        do.call(rbind, res)
    } else NULL
}
