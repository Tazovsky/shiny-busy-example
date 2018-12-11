library(shiny)
library(shinydashboard)

header <- dashboardHeader(
  title = "\"shiny-busy\" example"
)

body <- dashboardBody(
  
  # when shiny processing something it has class "shiny-busy" class
  # it can be easily used, for example for global loading indicator
  # many of loading indicator are available for free on page https://loading.io/
  conditionalPanel(condition = "($('html').hasClass('shiny-busy'))",
                   tags$div(
                     id = "loadingIndicator",
                     style = paste(
                       "margin: 0px;",
                       "padding: 0px;",
                       "position: fixed;",
                       "right: 0px;",
                       "top: 0px;",
                       "width: 100%;",
                       "height: 100%;",
                       "z-index: 30001;",
                       "opacity: 0.8;"
                     ),
                     tags$p(style = "position: absolute; top: 50%; left: 45%;",
                            tags$img(src = "Gear-0.2s-135px.svg"))
                   )),
  
  fluidRow(
    column(width = 3,
           box(width = NULL, solidHeader = TRUE,
               shiny::textInput(
                 inputId = "how_long",
                 label = "How long app should be busy?",
                 placeholder = "in second(s)",
                 value = 30L
               ),
               actionButton("wait", "Start"),
               br(),
               textOutput("info")
               
           )
    )
  )
)

ui <- dashboardPage(
  header,
  dashboardSidebar(disable = TRUE),
  body
)

server <- function(input, output, session) {
  
  observeEvent(input$wait, ignoreInit = TRUE, {
    
    i <- 0
    
    while (i < as.numeric(input$how_long)) {
      i <- i + 1
      print(i)
      Sys.sleep(1L)
    }
    
  })
}

shinyApp(ui = ui, server = server)
