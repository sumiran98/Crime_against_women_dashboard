# Dashboard UI

ui <- dashboardPage(
  skin="purple",
  dashboardHeader(
    title = "Statewise Cases registered for Rape, Assault and Murder of Women",
    titleWidth = 650, 
    tags$li(class = "dropdown", tags$a(href = "https://www.linkedin.com/in/sumiran-naman-b5b38339/", icon("linkedin"), "My Profile", target = "_blank")),
    tags$li(class = "dropdown", tags$a(href = "https://github.com/sumiran98/Crime_against_women_dashboard", icon("github"), "Source code and Report", target = "_blank"))
  ),
  dashboardSidebar(
    
    sidebarMenu(
      id = "sidebar",
      menuItem("Dataset", tabName = "data", icon = icon("database")),
      menuItem(text = "Visualization", tabName = "viz", icon = icon("chart-line")),
      menuItem(text = "Analysis", tabName = "anova", icon = icon("chart-line"),badgeColor = "yellow"),
      selectInput(inputId = "var1", label = "Select the Crime", choices = choices1, selected = "Rape - 2015")
    )
  ),
  
  dashboardBody(
   # use_theme(my_theme),
    tabItems(
      #First tab item
      tabItem(tabName = "data",
              #tab box
              tabBox(id = "t1", width = 12,
                     tabPanel("About",
                              fluidRow(
                                column(width = 8,
                                       tags$br() , 
                                       tags$a("Welcome to the Crime Against Women Dashboard – a comprehensive tool designed to illuminate and analyze incidents of violence against women in India from 2014 to 2016. This dashboard serves as a vital resource for understanding the alarming trends and patterns related to crimes such as rape, murder, and assault. By presenting data-driven insights, we aim to foster awareness and empower individuals, policymakers, and communities to collaboratively address the pressing issue of violence against women. Explore the visualizations and statistics within this dashboard to gain a deeper understanding of the challenges faced, facilitating informed discussions and actions towards a safer and more secure environment for women in India.")),
                                column(width = 4, tags$br() ,
                                       tags$p("Abbrevations used are (CR) Case Registered")
                                )
                              )  
                              
                     ),
                     tabPanel("Data",dataTableOutput("dataT")),
                     tabPanel("Structure",verbatimTextOutput("structure")),
                     tabPanel("Summary",verbatimTextOutput("summary")))),
      tabItem(tabName = "viz",
              #tab box
              tabBox(id = "t1", width = 12,
                     tabPanel("Crime Trends by States",value = "trends", plotlyOutput("bar")),
                     tabPanel("Distribution", value = "distro",plotlyOutput("histplot")))),
      tabItem(tabName = "anova",
              tabBox(id = "t1", width = 12,
                     tabPanel("About",
                              fluidRow(
                                column(width = 8,
                                       tags$br() , 
                                       tags$a("This part of Dashboard compares different crimes per state over years using test of Anova")),
                                column(width = 4, tags$br())
                     
                     )),
                     tabPanel("CR", verbatimTextOutput("CR")),
                     tabPanel("Murder", verbatimTextOutput("Murder")),
                     tabPanel("Rape", verbatimTextOutput("Rape")),
                     tabPanel("Assault", verbatimTextOutput("Assault"))#,
                     #tabPanel("PCS", verbatimTextOutput("PCS")),
                     #tabPanel("PCV", verbatimTextOutput("PCV"))
    )
    
  )
)))
