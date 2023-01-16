library(shiny)

ui <- fluidPage(
  fluidRow(
    column(
      width = 4,
      offset = 4,
      textInput("email", label = "Email"),
      passwordInput("password", "Senha"),
      actionButton("enviar", "Enviar")
    )
  )
)

server <- function(input, output, session) {

}

shinyApp(ui, server)
