shinyUI(pageWithSidebar(
 
  headerPanel("Caloric Deficit and Weight Loss",),
  
  sidebarPanel(
    numericInput("defspan", "Number of days to average caloric deficit:",1,min=1),
    numericInput("lossspan", "Number of days to average weight loss:",1,min=1),
    numericInput("lag", "Time lag in days between intake and weight change:",0,min=0)
  ),
  
  mainPanel(
    tabsetPanel(
  
    tabPanel("Documentation",
        br(),
        strong("A project for JHU's ", em("Developing Data Products"), " Coursera course"),
        br(),br(),
        p("This is a simple app to examine the effect of caloric deficit on weight loss. One
          commonly cited figure (of questionable validity) is that in order to lose one pound,
          one must achieve a cumulative caloric deficit of 3500kcal. In order to probe this 
          figure, one can measure daily caloric intake/expenditure and net change in weight
          every day. This app plots this data, fits a line, and indicates the confidence
          intervals in grey."),
        br(),
        p("Furthermore, the app lets you plot multi-day averages, to see how
          the effect changes with time-scale. For example, if the input data is 2, 3 and 1, the
          first data point would be the average deficit over days 1-2 and the average daily
          weight loss for days 2-4."),
        br(), 
        p("The default data set is a 68-day record of the author's own weight and caloric
          deficit. Admittedly, this sample size is probably too small to draw firm conclusions.
          But the data does show a significant effect, with a stronger slope than expected:
          the linear fit indicates, on a day-to-day basis, only a 1100kcal deficit is needed
          to lose one pound. This figure increases markedly however when one considers 
          multi-day averages."),
        br(),
        p("The files ",em("ui.R")," and ", em("server.R"), " can be found at ", 
          a(href = "https://github.com/dprooney/WeightLoss",target = "_blank",
            "the github repository.")
        )
      ),

      tabPanel("Results",
        plotOutput('fit'),
        br(),
        strong("1/Coefficient (kcal/lbs):"),
        textOutput('result1'),
        br(),
        strong("p-value:"),
        textOutput('result2'),
        br(),
        strong("R-squared:"),
        textOutput('result3')
      ),
      
      tabPanel("Raw Data",
        plotOutput('rawdata')
      )
    )
  )
))