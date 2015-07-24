require("XML")
require("plyr")
require("reshape2")
require("XBRL")

# Example sequence:
# pre <- xbrl.get.presentation("pru/pru-20131231.xml")
# contexts <- xbrl.get.contexts("pru/pru-20131231.xml")
# facts <- xbrl.get.facts("pru/pru-20131231.xml")
# clean_facts <- xbrl.strip.html(facts)
# merged <- xbrl.merge.data(clean_facts, contexts)
# write.table(merged, file="pru_merged.csv", row.name=FALSE, sep = ",")

##========================

xbrl.get.segments <- function(xmlContext){
  members <- c()
  
  segment <- xmlContext[[1]][[2]]
  for(n in 1:xmlSize(segment)){
    members <- c(members, xmlValue(segment[[n]]))  
  }

  paste(members, collapse=", ")  
}

xbrl.merge.data <- function(facts, contexts){
  join(facts, contexts, by="contextId")  
}

xbrl.strip.html <- function(facts){

  for(n in 1:nrow(facts)){
    stringValue <- as.character(facts[n,]['fact'][1,1]) 
    numericValue <- as.numeric(stringValue)
      
    if(grepl("<", stringValue)){
      facts[n,]['fact'][1,1] <- NA  
    }
  }
  
  facts
}

xbrl.get.roles <- function(pre, concept){

  roles <- subset(pre, toElementId == concept)[,1]
  factorValues <- c(roles[1:length(roles)])
  roleNames <- levels(roles)[factorValues]
  
  for(m in 1:length(roleNames)){
    match <- regexpr("\\/[^\\/]*$", roleNames[m])
    if(match[1] > 0){
      roleNames[m] <- substring(roleNames[m], match[1]+1)  
    }
  }
  
  return(paste(roleNames, collapse = ","))
}

# "metlife/met-20131231.xml"
xbrl.get.facts <- function(location){
  doc <- xbrlParse(location)
  facts <-  xbrlProcessFacts(doc)      
  
  roles <- c()
  
  for(n in 1:nrow(facts)){
    concept <- as.character(facts[n,'elementId'])
    role <- xbrl.get.roles(pre, concept)
    roles <- c(roles, role)  
  }
  facts <- cbind(facts, roles)
  facts
}

# "metlife/met-20131231_pre.xml"
xbrl.get.presentation <- function(location){
  doc <- xbrlParse(location)
  pre <-  xbrlProcessArcs(doc, "presentation") 
  pre
}

# "metlife/met-20131231.xml"
xbrl.get.contexts <- function(location){
  doc <- xbrlParse(location)
  contexts <-  xbrlProcessContexts(doc) 
  contexts
}
