ui <-fluidPage(
  tags$head(
    tags$style(HTML("
                    @import url('https://fonts.googleapis.com/css?family=Neucha|Cabin+Sketch');
                    
                    h1 {
                    font-family: 'Neucha', cursive;
                    font-weight: 500;
                    line-height: 1.1;
                    color: #212529;
                    }
                    
                    "))
    ),
#the above code makes the fond change!!
  
  headerPanel("Scottish Index of Multiple Depravation"),
  
  sidebarPanel(
    # Input: Selector for variable to plot against mpg ----
    selectInput("variable", "Variable:", 
                c("Council Area" = "Council_Area", "Urban" = "Urban",
                  "Postcode" = "PostCode","Health Board" = "Health_Board",
                  "Population" = "Population", "Adult Population" = "AdultP", 
                  "Overcrowding Percentage" = "Overcrowding", "Literacy Rate" = "Literacy", 
                  "Good Health %" = "GoodHealth", "Part-Time Workers" = "PTws", "Full-Time Workers" ="FTws",
                  "SE Workers" = "SEws", "Percentage of Unemployed Individuals" = "Unemployment","Male Unemployment Rates" = "MaleUnemp",
                  "Percentage of Disabled Individuals" = "Disabled", "Percentage of Staying Home Individuals" = "HomeStayed", 
                  "Percentage of Low Class" = "LowClass")),
    
    # Input: Checkbox for whether outliers should be included ----
    checkboxInput("outliers", "Show outliers", TRUE)
    
  ),
  # Main panel for displaying outputs ----
  mainPanel(
    
    # Output: Plot of the requested variable against PS ----
    mainPanel(plotOutput("ScotPlot"))
    
  ))
