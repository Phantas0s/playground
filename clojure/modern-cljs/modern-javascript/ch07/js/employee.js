// employee.js #2
// This script creates an object using form data.

// Function called when the form is submitted.
// Function creates a new object.
function process() {
    'use strict';

    // Get form references:
    var firstName = document.getElementById('firstName').value;
    var lastName = document.getElementById('lastName').value;
    var department = document.getElementById('department').value;

    // Reference to where the output goes:
    var output = document.getElementById('output');

    // Create a new object:
    var employee = {
        firstName: firstName,
        lastName: lastName,
        department: department,
        getName: function() {
            return this.lastName + ', ' + this.firstName;
        },
        hireDate: new Date()
    }; // Don't forget the semicolon!
    
    // Create the ouptut as HTML:
    var message = '<h2>Employee Added</h2>Name: ' + employee.getName() + '<br>';
    message += 'Department: ' + employee.department + '<br>';
    message += 'Hire Date: ' + employee.hireDate.toDateString();
    
    // Display the employee object:
    output.innerHTML = message;
        
    // Return false:
    return false;
    
} // End of process() function.

// Initial setup:
function init() {
    'use strict';
    document.getElementById('theForm').onsubmit = process;
} // End of init() function.
window.onload = init;