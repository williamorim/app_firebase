library(shiny)
library(firebase)

ui <- fluidPage(
  "Eita",
  useFirebase(), # import dependencies
  firebaseUIContainer(),
  reqSignin(h4("Eita!")), # hide from UI
  textOutput("signin")
)

server <- function(input, output){
  f <- FirebaseUI$
    new()$ # instantiate
    set_providers( # define providers
      email = TRUE
    )$
    launch() # launch

  s <- Storage$new() # initialise

  output$signin <- renderText({
    paste("TESTE:", f$get_signed_in())
  })
}

shinyApp(ui, server)
