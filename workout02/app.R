
#-------------------------------------
# Fluid
#-------------------------------------
library(shiny)
library(reshape)
library(ggplot2)
ui <- fluidPage(
  titlePanel("Investment Model"),
  flowLayout(
  
  sliderInput(inputId = "ia",
              label = "Initial Amount",
              value = 1000, min = 1, max = 100000,pre = "$", sep = ","),
  sliderInput(inputId = "rr",
              label = "Return Rate (in %)",
              value = 5, min = 0, max = 20),
  sliderInput(inputId = "years",
              label = "Years",
              value = 10, min = 0, max = 50)),
  
  flowLayout(
  sliderInput(inputId = "ac",
              label = "Annual Contribution",
              value = 2000, min = 0, max = 50000,pre = "$", sep = ","),
  sliderInput(inputId = "gr",
              label = "Growth Rate (in %)",
              value = 2, min = 0, max = 20),
  selectInput("facet", "Facet?",
              choices = c("No", "Yes"))),
  h4("Timeline"),
  plotOutput("graf"),
  h4("Balances"),
  verbatimTextOutput("default")
)

#-------------------------------------
# Functions
#-------------------------------------

future_value <- function(amount = 0, rate = 0, years = 0) {
  fv <- amount*(1+rate)^years
  return(fv)
  
}

annuity <- function(contrib = 0, rate = 0, years = 0) {
  fva <- contrib*(((1+rate)^years-1)/(rate))   
  return(fva)
  
}

growing_annuity <- function(contrib = 0, rate = 0, growth = 0, years = 0) {
  fvga <- contrib*(((1+rate)^years-(1+growth)^years)/(rate-growth))   
  return(fvga)
  
}

#-------------------------------------
# Simulations
#-------------------------------------



#-------------------------------------
# Server
#-------------------------------------

server <- function(input, output) {
  output$graf <- renderPlot({
    
    m <- input$years
    aloha <- 0
    aloha_1 <- 0
    aloha_2 <- 0
    
    
    for (j in 0:m) {
      no_contrib = future_value(amount = input$ia, rate = input$rr/100, years = j)
      aloha[j+1] <- no_contrib
    }
    
    for (j in 0:m) {
      fixed_contrib = annuity(contrib = input$ac, rate = input$rr/100, years = j) + future_value(amount = input$ia, rate = input$rr/100, years = j)
      aloha_1[j+1] <- fixed_contrib
      
    }
    
    for (j in 0:m) {
      growing_contrib = growing_annuity(contrib = input$ac, rate = input$rr/100, growth = input$gr/100, years = j) + future_value(amount = input$ia, rate = input$rr/100, years = j)
      aloha_2[j+1] <- growing_contrib
    }
    
    
    modalities = data.frame(
      year = 0:m,
      no_contrib = aloha,
      fixed_contrib = aloha_1,
      growing_contrib = aloha_2
      )
    
    meata <-  melt(modalities, id=c("year"))
    
    if (input$facet == "No") {
      ggplot(meata, mapping = aes(x = year, y = value, color =  variable) ) + 
        geom_line() + 
        geom_point() + 
        theme_grey() +
        labs(title ="Three Modes of Investing", x = "Time (Year)", y = "Value ($)")
    } else {
      ggplot(meata, aes(year,value))+ 
        geom_point(aes(color = variable)) +
        geom_line(aes(color = variable)) + 
        geom_area(aes(fill = variable), alpha=0.5) +
        facet_grid(. ~variable, labeller = label_parsed) +
        theme_bw() +
        labs(title ="Three Modes of Investing", x = "Time (Year)", y = "Value ($)")
    }
  
  })
  
  output$default <- renderPrint({ 
    m <- input$years
    aloha <- 0
    aloha_1 <- 0
    aloha_2 <- 0
    
    
    for (j in 0:m) {
      no_contrib = future_value(amount = input$ia, rate = input$rr/100, years = j)
      aloha[j+1] <- no_contrib
    }
    
    for (j in 0:m) {
      fixed_contrib = annuity(contrib = input$ac, rate = input$rr/100, years = j) + future_value(amount = input$ia, rate = input$rr/100, years = j)
      aloha_1[j+1] <- fixed_contrib
      
    }
    
    for (j in 0:m) {
      growing_contrib = growing_annuity(contrib = input$ac, rate = input$rr/100, growth = input$gr/100, years = j) + future_value(amount = input$ia, rate = input$rr/100, years = j)
      aloha_2[j+1] <- growing_contrib
    }
    
    
    modalities = data.frame(
      year = 0:m,
      no_contrib = aloha,
      fixed_contrib = aloha_1,
      growing_contrib = aloha_2
    )
    modalities
    
    
    })

}



#-------------------------------------
# App
#-------------------------------------

shinyApp(server = server, ui = ui)

