# Database 

* **Original Database:** daily-website-visitors.csv 
* **Cleaned Dataset:** web_visit.csv
* Data Cleaning: R-programming
''' 
web_visit <- read.csv("daily-website-visitors.csv", header = TRUE)

web_visit$Page.Loads <- as.numeric(gsub(",", "", web_visit$Page.Loads))
web_visit$Unique.Visits <- as.numeric(gsub(",", "", web_visit$Unique.Visits))
web_visit$First.Time.Visits <- as.numeric(gsub(",", "", web_visit$First.Time.Visits))

write.csv(web_visit, "/Users/alex/Desktop/web_visitor.csv", row.names = TRUE)
'''
