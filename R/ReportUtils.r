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


