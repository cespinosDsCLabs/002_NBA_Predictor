library(rvest)
library(lubridate)
library(tidyverse)
library(stringr)
library(zoo)
library(h2o)
library(lubridate)



teams<-c("tor", "mil", "den", "gs", "ind", "phi", "okc", "por", "bos", "hou", "lac", "sa",
         "lal", "utah", "mia", "sac", "min", "bkn", "dal", "no", "cha", "mem", "det", "orl",
         "wsh", "atl", "phx", "ny", "chi", "cle")

teams_fullname<-c("Toronto", "Milwaukee", "Denver", "Golden State", "Indiana", "Philadelphia", "Oklahoma City","Portland",
                  "Boston", "Houston", "LA", "San Antonio", "Los Angeles", "Utah", "Miami", "Sacramento", "Minnesota", "Brooklyn",
                  "Dallas", "New Orleans", "Charlotte", "Memphis", "Detroit", "Orlando", "Washington", "Atlanta", "Phoenix",
                  "New York", "Chicago", "Cleveland")

by_team<-{}
for (i in 1:length(teams)) {
  url<-paste0("http://www.espn.com/nba/team/schedule/_/name/", teams[i])
  #print(url)
  webpage <- read_html(url)
  team_table <- html_nodes(webpage, 'table')
  team_c <- html_table(team_table, fill=TRUE, header = TRUE)[[1]]
  team_c<-team_c[1:which(team_c$RESULT=="TIME")-1,]
  team_c$URLTeam<-toupper(teams[i])
  team_c$FullURLTeam<-(teams_fullname[i])
  by_team<-rbind(by_team, team_c)
}

# remove the postponed games
by_team<-by_team%>%filter(RESULT!='Postponed')


