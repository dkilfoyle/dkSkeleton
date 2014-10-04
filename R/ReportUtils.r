require(Gmisc)

# gmisc htmlTable automatic numbering
options(table_counter = T)
options(table_counter_str = "<b>Table %s:</b> ")

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


