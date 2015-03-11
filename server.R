library(shiny)
wldata <- read.csv('data/CPdata.csv')

shinyServer(
  
    function(input, output) {
      
      output$fit <- renderPlot({
        N <- 68 - max(input$lossspan + input$lag, input$defspan) + 1
        procdf <- data.frame(Deficit = rep(0,N),Loss = rep(0,N))
    
        for (j in 1:N){
          procdf[j,1] = mean(wldata[(j+input$lag):(j+input$defspan-1+input$lag),1])
          procdf[j,2] = mean(wldata[j:(j+input$lossspan-1),2])
        }
        mod <- lm(Loss~Deficit, procdf)

        newdef <- seq(min(wldata$Deficit),max(wldata$Deficit),length.out=100)
        preds <- predict(mod, newdata=data.frame(Deficit=newdef), interval='confidence') 
        
        plot(procdf$Deficit,procdf$Loss,type="n",xlab="Caloric Deficit (kcal)",
             ylab = "Weight Loss (lbs)",xlim = c(1.1*min(wldata$Deficit),1.1*max(wldata$Deficit)),
             ylim = c(1.1*min(wldata$Loss),1.1*max(wldata$Loss)) )

        polygon(c(rev(newdef),newdef),c(rev(preds[,3]),preds[,2]),col='grey80',border=NA)
        points(procdf$Deficit,procdf$Loss,col="blue" )
        abline(mod,col="red",lwd=3)
      })
      
      output$result1 <- renderText({
        
        N <- 68 - max(input$lossspan + input$lag, input$defspan) + 1
        procdf <- data.frame(Deficit = rep(0,N),Loss = rep(0,N))
        
        for (j in 1:N){
          procdf[j,1] = mean(wldata[(j+input$lag):(j+input$defspan-1+input$lag),1])
          procdf[j,2] = mean(wldata[j:(j+input$lossspan-1),2])
        }
        mod <- summary(lm(Loss~Deficit, procdf))
        1/mod$coefficients[2,1]
      })
      
      output$result2 <- renderText({
        
        N <- 68 - max(input$lossspan + input$lag, input$defspan) + 1
        procdf <- data.frame(Deficit = rep(0,N),Loss = rep(0,N))
        
        for (j in 1:N){
          procdf[j,1] = mean(wldata[(j+input$lag):(j+input$defspan-1+input$lag),1])
          procdf[j,2] = mean(wldata[j:(j+input$lossspan-1),2])
        }
        mod <- summary(lm(Loss~Deficit, procdf))
        mod$coefficients[2,4]
      })

      output$result3 <- renderText({
        
        N <- 68 - max(input$lossspan + input$lag, input$defspan) + 1
        procdf <- data.frame(Deficit = rep(0,N),Loss = rep(0,N))
        
        for (j in 1:N){
          procdf[j,1] = mean(wldata[(j+input$lag):(j+input$defspan-1+input$lag),1])
          procdf[j,2] = mean(wldata[j:(j+input$lossspan-1),2])
        }
        mod <- summary(lm(Loss~Deficit, procdf))
        mod$r.squared  
      })
      
      output$rawdata <- renderPlot({
        
        weights = rep(0,69)
        weights[1] = 183.2
        
        for (j in 1:68){
          weights[j+1] = weights[j]+wldata[69-j,2]
        }
        plot(as.ts(weights),xlab="Day", ylab = "Weight (lbs)", col='blue'  )
      })
  }
)