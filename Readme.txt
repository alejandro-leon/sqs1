SQS version 0.1.9

The Sales Quotig System is an application that aids in the creation of saless quotes.

Quick Guide

Requirements:
- A computer that can run the latest Java Runtime Environment.
- Maybe a finger or two.

To run the application, open a terminal window to access the command line.
Navigate to the directory where the sqs-0.1.9-java.jar file is located.  
At the prompt type the following command:
java -jar sqs-0.1.9-java.jar

The files in the "data" directory contain all the data that will be accessed by the application. 
Please don't remove or rename the files in that directory, or the program will cease to function and you will stop enjoying all its benefits.
The "users.txt" file is the password file and contains authorized users for the system.  Edit this file to change login and user information.
The "products.txt" file contains the products to be selected for the quotes.  Edit this file to change product information.
The "discounts.txt" file includes the discount percentages matching their counterpart weight thresholds.  Edit this file to change discount information.

To add or remove new items, just edit the above files following the same format pattern shown in the examples included in the files.

The source directory contains the source code for the SQS application in Ruby code.
This can be run with the Ruby application.  
At the command prompt in the 'source' directory type:
ruby sqs.rb

If you have any real questions, find any bugs or have any constructive criticism, please feel free to e-mail the author at: ala3@student.london.ac.uk


Hope you enjoy the program and have a happy quoting!

Alejandro León
Date 30/04/2012