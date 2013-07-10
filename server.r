shinyServer(function(input, output) {


    output$main_plot <- reactivePlot(width = 400, height = 300, function() {

    hist(faithful$eruptions,
      probability = TRUE,
      breaks = as.numeric(input$n_breaks),
      xlab = "Duration (minutes)",
      main = "Geyser eruption duration")

    if (input$individual_obs) {
      rug(faithful$eruptions)
    }

    if (input$density) {
      dens <- density(faithful$eruptions, adjust = input$bw_adjust)
      lines(dens, col = "blue")
    }

  })
})
library(shiny)

# Define server logic for random distribution application
shinyServer(function(input, output) {

      # Reactive expression to generate the requested distribution. This is
      # called whenever the inputs change. The renderers defined
      # below then all use the value computed from this expression
      data <- reactive({
              dist <- switch(input$dist,
                                                norm = rnorm,
                                                unif = runif,
                                                lnorm = rlnorm,
                                                exp = rexp,
                                                rnorm)

                  dist(input$n)
          })

        # Generate a plot of the data. Also uses the inputs to build the
        # plot label. Note that the dependencies on both the inputs and
        # the 'data' reactive expression are both tracked, and all expressions
        # are called in the sequence implied by the dependency graph
        output$plot <- renderPlot({
                dist <- input$dist
                    n <- input$n

                    hist(data(),
                                  main=paste('r', dist, '(', n, ')', sep=''))
            })

        # Generate a summary of the data
        output$summary <- renderPrint({
                summary(data())
            })

        # Generate an HTML table view of the data
        output$table <- renderTable({
                data.frame(x=data())
            })
  })
