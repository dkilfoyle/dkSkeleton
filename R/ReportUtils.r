library(knitr)
ReportName = "Report"

# knitr setup
opts_chunk$set(comment="", echo=F)
opts_chunk$set(message=F, warning=F)
fn = local({
  i = 0
  function(x) {
    i <<- i + 1
    paste('Figure ', i, ': ', x, sep = '')
  }
})
tn = local({
  i = 0
  function(x) {
    i <<- i + 1
    paste('\n\n:Table ', i, ': ', x, sep = '')
  }
})

knit_hooks$set(tab.cap = function(before, options, envir) {
  if(!before)
    tn(options$tab.cap)
})
default_output_hook = knit_hooks$get("output")
knit_hooks$set(output = function(x, options) {
  if (is.null(options$tab.cap) == F) 
    x
  else
    default_output_hook(x,options)
})

# rstudio setup
options(rstudio.markdownToHTML = 
          function(inputFile, outputFile) {      
            require(markdown)
            markdownToHTML(inputFile, outputFile, stylesheet='buttondown.css')   
          }
)

# postpro only works on pandoc html5 files
postpro = function() {
  tiasource = paste(readLines(paste0(ReportName,".html")), collapse="\n")
  library(knitcitations)
  library(gsubfn)
  bib = read.bibtex("Report.bib")
  x=gsubfn("data-cites=\"([a-zA-Z0-9]*)\"", function(x,y) {
    if (y %in% names(bib))
      paste("data-cites=\"", 
            bib[y]$author[[1]]$family, " et al. ",
            bib[y]$title, ". ",
            bib[y]$journal, " ",
            bib[y]$year,  ".",
            "\"", sep="")
    else
      x
  }, tiasource, backref=1)
  cat(x, file=paste0(ReportName, ".html"))
}

dkpandoc = function() {
  render_markdown()
  # render_html() # use this for knitr source highlighting
  knit(paste0(ReportName,".rmd"))
  pandoc(paste0(ReportName, ".md"), format="html5")
  postpro()
}
