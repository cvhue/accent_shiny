shinyUI(bootstrapPage(


    # Decimal interval with step value
    sliderInput("decimal", "Preference:", 
                min = 0, max = 1, value = 0.5, step= 0.1),

  plotOutput(outputId = "main_plot", height = "300px"),

  # Display this only if the density is shown
  conditionalPanel(condition = "input.density == true",
    sliderInput(inputId = "bw_adjust",
                label = "Bandwidth adjustment:",
                min = 0.2, max = 2, value = 1, step = 0.2)
  )

))
library(shiny)

# Define UI for random distribution application
shinyUI(pageWithSidebar(

      # Application title
      headerPanel("Tabsets"),

      # Sidebar with controls to select the random distribution type
      # and number of observations to generate. Note the use of the br()
      # element to introduce extra vertical spacing
      sidebarPanel(
              radioButtons("dist", "Distribution type:",
                                            list("Normal" = "norm",
                                                                       "Uniform" = "unif",
                                                                       "Log-normal" = "lnorm",
                                                                       "Exponential" = "exp")),
              br(),

              sliderInput("n",
                                          "Number of observations:",
                                           value = 500,
                                           min = 1,
                                           max = 1000)
            ),


                                        # Show a tabset that includes a plot, summary, and table view
      # of the generated distribution
      mainPanel(
              tabsetPanel(
                        tabPanel("Plot", plotOutput("plot")),
                        tabPanel("Summary", verbatimTextOutput("summary")),
                        tabPanel("Table", tableOutput("table"))
                      )
            )
    ))
