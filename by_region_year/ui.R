
# Get current year. 
stop_year <- as.numeric(substr(Sys.Date(), 1, 4))
years <- as.character(2001:stop_year)

shinyUI(fluidPage(
  titlePanel("Crime in Chicago: by Region"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Annual counts and rates for different crime categories: by 
               Region"),
      
      selectInput("type", 
                  label = "Select Crime Category",
                  choices = list("All","Homicides", "Non-fatal Shootings", "Violent Crimes: Def 1", "Violent Crimes: Def 2",
                                 "Property", "Drugs", "Weapons"),
                  selected = "Violent Crimes: Def 1"),
      
      selectInput("year",
                  label = "Select Year",
                  choices = as.list(years),
                  selected = as.character(stop_year - 1)),
      
      selectInput("region", 
                  label = "Select Region", 
                  choices = list("Community Areas", "Police Districts"), 
                  selected = "Community Areas"),
      
      selectInput("order_by",
                  label = "Order By Rate or Total",
                  choices = list("Rate", "Total"),
                  selected = "Rate"),
      
      selectInput("add_arrests", 
                  label = "Include Arrest Columns", 
                  choices = list("Yes", "No"), 
                  selected = "No"),
      
      textInput(inputId = "title", label = "Plot Title"),
      downloadButton('downloadData','Save Table'),
      downloadButton('downloadPlot','Save Plot'),
      
      
      tags$p(tags$br()),
      tags$p(tags$br()),
      
      tags$h4(tags$u("Definitions")),
      tags$table(style = "width:100%", border = "1", cellspacing = "2",
                 tags$tr(tags$th("TYPE"), tags$th("FBI Codes")),
                 tags$tr(tags$td("Homicides"), tags$td("01A")),
                 tags$tr(tags$td("Non-fatal Shoogings"), tags$td("04B + Description includes HANDGUN, RIFLE, or FIREARM")),
                 tags$tr(tags$td("Violent crimes: def 1"), tags$td("01A, 02, 03, 04A, 04B")),
                 tags$tr(tags$td("Violent crimes: def 2"), tags$td("01A, 02, 03, 04A, 04B, 08A, 08B")),
                 tags$tr(tags$td("Property"), tags$td("05, 06, 07, 09")),
                 tags$tr(tags$td("Drugs"), tags$td("18")),
                 tags$tr(tags$td("Weapons"), tags$td("15"))),
      tags$a("FBI Code Definitions", href = "http://gis.chicagopolice.org/clearmap_crime_sums/crime_types.html"),
      tags$p(tags$br()),
      
      tags$h4(tags$u("Other Crime Apps")),
      tags$table(stype = "width:100%",
                 tags$tr(tags$td(tags$a("Year-to-Date Crime Totals", href = "https://welgus-apps.shinyapps.io/year_to_date"))),
                 tags$tr(tags$td(tags$a("Monthly Crime Rates", href = "https://welgus-apps.shinyapps.io/by_month"))))),
    mainPanel( 
    
      tabsetPanel(
        tabPanel("Table", tableOutput("table")), 
        tabPanel("Plot", plotOutput("plot")))))
))
