

library(shiny)
library(leaflet)
library(shinythemes)

style_choices <- c("Coffee", "NonCoffee")

ui <- fluidPage(theme = shinytheme("superhero"),
    titlePanel("Starbucks Drinks Recommendation"),

    sidebarLayout(
        sidebarPanel(
            helpText("Get your Drinks!"),

            selectInput("store", label = "Select starbucks store", choices = unique(star$Store), "Store"),
            selectInput("Type", label = "Select type of drinks", style_choices, "Type"),
            submitButton("GO")

        ),
    mainPanel(
      
      navbarPage(h2("Starbucks"), id="main",
                 tabPanel(h2("Map"),h2("Malaysian Starbucks Map"),leafletOutput("map", height = 1000)),
                 tabPanel(h2("Recommendation"),h2("Recommend Drinks!"), verbatimTextOutput("drinks")))
    )
      
    ),

   )
