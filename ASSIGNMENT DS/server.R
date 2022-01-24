
library(shiny)
library(dplyr)
library(leaflet)
library(DT)

shinyServer(function(input, output) {
  #Import data and clean it
  
  star <- read.csv("Store.csv")
  star <- data.frame(star)
  star$Latitude <- as.numeric(star$Latitude)
  star$Longitude <- as.numeric(star$Longitude)
  
  #new column for the popup label
  
  star2 <- mutate(star, cntnt=paste0('<strong>Name: </strong>',Store,
                                     '<br><strong>Rating:</strong>',Rating))
  
  #Output for recommendation drinks
  
    output$drinks <- renderText({

      chooseStore <- input$store
      storeData <- filter(star, star$Store == chooseStore)

      type <- input$Type
      if(type == "Coffee"){
        storeData$Coffee
      }else{
        storeData$NonCoffee
      }
      })
    
    pal <- colorFactor(pal = "#1b9e77", domain = "Store")

      #Output for map
      
    output$map <- renderLeaflet({
      leaflet(star) %>%
        addCircles(lng = ~Longitude, lat = ~Latitude) %>%
        addTiles() %>%
        addCircleMarkers(data = star2, lat = ~Latitude, lng = ~Longitude,
                         radius = 4, popup = ~as.character(cntnt),
                         color = ~pal(Category),
                         stroke = FALSE, fillOpacity = 0.8) %>%
        addLegend(pal = pal, values = star2$Category,opacity = 1) %>%
        addEasyButton(easyButton(
          icon="fa-crosshairs", title="ME",
          onClick = JS ("function(btn,map){ map.locate({setView: true}); }")
        ))

      
      
    })  

})
