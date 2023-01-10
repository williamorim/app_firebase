library(shiny)

ui <- fluidPage(
    textInput("teste", "Inserir true"),
    actionButton("botao", "Enviar")
  )

server <- function(input, output, session) {
  observeEvent(input$botao, {
    if (input$teste == "true") {
     stopApp(returnValue = TRUE)
    }
  })
}

shinyApp(ui, server, options = list(port = 4242))
