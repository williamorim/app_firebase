library(shiny)
library(firebase)

ui <- navbarPage(
  title = "Firebase",
  id = "menu_superior",
  tabPanel(
    title = "Home",
    useFirebase(),
    fluidRow(
      column(
        width = 6,
        includeMarkdown("texto_inicial.md")
      ),
      column(
        offset = 2,
        width = 4,
        br(),
        br(),
        shinyWidgets::actionBttn(
          inputId = "bt_login",
          label = "Fazer login",
          size = "lg"
        ),
        br(),
        shinyWidgets::actionBttn(
          inputId = "bt_logout",
          label = "Fazer logout",
          size = "lg"
        )
      )
    )
  )
)

server <- function(input, output) {

   f <- FirebaseEmailPassword$new()

   observeEvent(input$bt_login, {
     showModal(
       modalDialog(
         title = "Login",
         footer = modalButton("Cancelar"),
         easyClose = TRUE,
         textInput(
           "email",
           label = "Email"
         ),
         passwordInput(
           "senha",
           label = "Senha"
         ),
         actionButton(
           inputId = "bt_entrar",
           label = "Entrar"
         )
       )
     )
   })

   observeEvent(input$bt_entrar, {
     f$sign_in(input$email, input$senha)
   })

  observeEvent(f$get_signed_in(), {

    f$req_sign_in()

    removeModal()
    removeUI(selector = "#bt_login")

    insertTab(
      inputId = "menu_superior",
      tab = tabPanel(
        title = "Página 1",
        selectInput(
          "variavel",
          label = "Selecione uma variável",
          choices = names(mtcars)
        ),
        plotOutput("grafico")
      )
    )

    insertTab(
      inputId = "menu_superior",
      tab = tabPanel(
        title = "Página 2",
        selectInput(
          "variavel_x",
          label = "Selecione uma variável para o eixo X",
          choices = names(mtcars)
        ),
        selectInput(
          "variavel_y",
          label = "Selecione uma variável para o eixo Y",
          choices = names(mtcars)
        ),
        plotOutput("grafico2")
      )
    )
  })


  output$grafico <- renderPlot({
    hist(mtcars[[input$variavel]])
  })

  output$grafico2 <- renderPlot({
    plot(x = mtcars[[input$variavel_x]], y = mtcars[[input$variavel_y]])
  })


  observeEvent(input$bt_logout, {
    f$sign_out()
  })

  observeEvent(f$get_sign_out(), {

    removeTab(
      inputId = "menu_superior",
      target = "Página 1"
    )

    removeTab(
      inputId = "menu_superior",
      target = "Página 2"
    )

  })

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
