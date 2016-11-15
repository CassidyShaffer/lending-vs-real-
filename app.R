## Get and display exoplanet data ----
## apps pulls data twice, fix to only require one ----
## This is a test commit

library(DT)
library(threejs)

ui <- bootstrapPage(
  tabsetPanel(type = "tabs",
              tabPanel("Lending", DT::dataTableOutput("datatable1")),
              tabPanel("Real", DT::dataTableOutput("datatable2")),
              tabPanel("Real plot", threejs::scatterplotThreeOutput("plot1")),
              tabPanel("Lending plot", threejs::scatterplotThreeOutput("plot2"))
  )
)

server <- function(input, output){
  
  output$datatable1 <- DT::renderDataTable({ 
   
    lending <- read.csv("E:/college/aFALL 2016/RStudio project/lending.csv", header = TRUE, stringsAsFactors = FALSE)
    
    
    
    DT::datatable(lending, options = list(pageLength = 15))
    
  })
   
  angola <- lending[lending$Country.Name == "Angola", -c(1:4, dim(real)[2])]
  argentina <- lending[lending$Country.Name == "Argentina", -c(1:4, dim(real)[2])]
  armenia <- lending[lending$Country.Name == "Armenia", -c(1:4, dim(real)[2])]
 
  data.three2 <- matrix(cbind(as.numeric(angola), as.numeric(argentina), as.numeric(armenia)), nrow = length(angola), ncol = 3)
  scatterplot3js(x = data.three2, color = rainbow(length(data.three2[,2])), label.margin = TRUE, flip.y = TRUE)
  
  output$datatable2 <- DT::renderDataTable({ 
    
    real <- read.csv("E:/college/aFALL 2016/RStudio project/real.csv", header = TRUE, stringsAsFactors = FALSE)

   
    
    DT::datatable(real, options = list(pageLength = 15))
   
  })
  
  output$plot1 <- threejs::renderScatterplotThree({
    
    
    angola <- real[real$Country.Name == "Angola", -c(1:4, dim(real)[2])]
    argentina <- real[real$Country.Name == "Argentina", -c(1:4, dim(real)[2])]
    armenia <- real[real$Country.Name == "Armenia", -c(1:4, dim(real)[2])]
    
    data.three2 <- matrix(cbind(as.numeric(angola), as.numeric(argentina), as.numeric(armenia)), nrow = length(angola), ncol = 3)
    scatterplot3js(x = data.three2, color = rainbow(length(data.three2[,2])), label.margin = TRUE, flip.y = TRUE)
    
  })

  
  output$plot2 <- threejs::renderScatterplotThree({
    
    
  angola <- lending[lending$Country.Name == "Angola", -c(1:4, dim(real)[2])]
  argentina <- lending[lending$Country.Name == "Argentina", -c(1:4, dim(real)[2])]
  armenia <- lending[lending$Country.Name == "Armenia", -c(1:4, dim(real)[2])]
 
  data.three2 <- matrix(cbind(as.numeric(angola), as.numeric(argentina), as.numeric(armenia)), nrow = length(angola), ncol = 3)
  scatterplot3js(x = data.three2, color = rainbow(length(data.three2[,2])), label.margin = TRUE, flip.y = TRUE)
 
  
  })
}
shinyApp(ui = ui, server = server)