# require(Gmisc)
library(htmlTable) #install_github("gforge/htmlTable")
require(knitr)

opts_chunk$set(dev="png", dev.args=list(type="cairo"), dpi=96)
opts_chunk$set(comment="") # remove the comment symbol from knitr output
opts_chunk$set(echo=F, fig.cap="")
opts_chunk$set(message=F, warning=F) # unless debugging

# decimals
options(scipen=3)

# gmisc htmlTable automatic numbering
options(table_counter = T)
options(table_counter_str = "<b>Table %s:</b> ")

fn = local({
  i = 0
  function(x) {
    i <<- i + 1
    paste('**Figure ', i, '**: ', x, sep = '')
  }
})

# Alternative to gmisc table_counter
# use tab.cap="my caption"
# tn = local({
#   i = 0
#   function(x) {
#     i <<- i + 1
#     paste('\n\n:Table ', i, ': ', x, sep = '')
#   }
# })
# 
# knit_hooks$set(tab.cap = function(before, options, envir) {
#   if(!before)
#     tn(options$tab.cap)
# })
# 
# ##default_output_hook = knit_hooks$get("output")
# 
# knit_hooks$set(output = function(x, options) {
#   if (is.null(options$tab.cap) == F) 
#     x
#   else
#     knitr:::.output(x, options)
#     ##default_output_hook(x,options)
# })
# 
# tn = local({
#   i = 0
#   function(x) {
#     i <<- i + 1
#     paste('\n\n:Table ', i, ': ', x, sep = '')
#   }
# })

# further figure/table numbering/referencing solution from: Peter Humburg
# http://galahad.well.ox.ac.uk/repro/#html-output

options(figcap.prefix = "Figure", figcap.sep = ":", figcap.prefix.highlight = "**")

figRef <- local({
  tag <- numeric()
  created <- logical()
  used <- logical()
  function(label, caption, prefix = options("figcap.prefix"), 
           sep = options("figcap.sep"), prefix.highlight = options("figcap.prefix.highlight")) {
    i <- which(names(tag) == label)
    if (length(i) == 0) {
      i <- length(tag) + 1
      tag <<- c(tag, i)
      names(tag)[length(tag)] <<- label
      used <<- c(used, FALSE)
      names(used)[length(used)] <<- label
      created <<- c(created, FALSE)
      names(created)[length(created)] <<- label
    }
    if (!missing(caption)) {
      created[label] <<- TRUE
      paste0(prefix.highlight, prefix, " ", i, sep, prefix.highlight, 
             " ", caption)
    } else {
      used[label] <<- TRUE
      paste(prefix, tag[label])
    }
  }
})

# example useage
# ```{r carDataPlot, fig.cap=figRef("carData", "Car speed and stopping distances from the 1920s.")}
# plot(cars)
# ```

tabRef <- local({
  tag <- numeric()
  created <- logical()
  used <- logical()
  function(label, caption, prefix = options("tabcap.prefix"), 
           sep = options("tabcap.sep"), prefix.highlight = options("tabcap.prefix.highlight")) {
    i <- which(names(tag) == label)
    if (length(i) == 0) {
      i <- length(tag) + 1
      tag <<- c(tag, i)
      names(tag)[length(tag)] <<- label
      used <<- c(used, FALSE)
      names(used)[length(used)] <<- label
      created <<- c(created, FALSE)
      names(created)[length(created)] <<- label
    }
    if (!missing(caption)) {
      created[label] <<- TRUE
      paste0(prefix.highlight, prefix, " ", i, sep, prefix.highlight, 
             " ", caption)
    } else {
      used[label] <<- TRUE
      paste(prefix, tag[label])
    }
  }
})

options(tabcap.prefix = "Table", tabcap.sep = ":", tabcap.prefix.highlight = "**")
