<!--- <!DOCTYPE html>
<html>
<head>
    <title>AJAX with CFML</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
    $(document).ready(function() {
        $('#fetchData').click(function() {
            $.ajax({
                url: 'data.cfc?method=getData',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    $('#result').html('Data: ' + data.message);
                },
                error: function(xhr, status, error) {
                    $('#result').html('Error: ' + error);
                }
            });
        });
    });
    </script>
</head>
<body>
    <button id="fetchData">Fetch Data</button>
    <div id="result"></div>
</body>
</html> --->

<!DOCTYPE html>
<html>
<head>
    <title>Form Submission with AJAX</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.21.0/jquery.validate.min.js" integrity="sha512-KFHXdr2oObHKI9w4Hv1XPKc898mE4kgYx58oqsc/JqqdLMDI4YjOLzom+EMlW8HFUd0QfjfAvxSL6sEq/a42fQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script>
    $(document).ready(function() {
        $("#myForm").validate({
            rules: {
                name: {
                    required: true,
                    minlength: 2
                },
                email: {
                    required: true,
                    email: true
                },
                password: {
                    required: true,
                    minlength: 5
                },
                phone: {
                    required: true,
                    minlength: 10,
                    maxlength: 10
                }
            },
            messages: {
                name: {
                    required: `Please enter your name`,
                    minlength: `Your name must be at least 2 characters long`
                },
                email: {
                    required: `Please enter your email address`,
                    email: `Please enter a valid email address`
                },
                password: {
                    required: `Please enter the password`,
                    minlength: `Password must be at least 5 characters long`
                },
                phone: {
                    required: `Please enter the phone number`,
                    minlength: `Phone number should be of 10 digits`,
                    maxlength: `Phone number should be of 10 digits`
                }
            },
            submitHandler: function(form) {
                var formData = {
                    user_id: $("#user_id").val(),
                    name: $("#name").val(),
                    email: $("#email").val(),
                    password: $("#password").val(),
                    phone: $("#phone").val()
                };
                $.ajax({
                    url: 'submit.cfc?method=insertdb',
                    type: 'POST',
                    data: formData,
                    success: function(data) {
                        alert("Successfully Registered");
                        $('#myForm')[0].reset();
                        if ($('#result table').length > 0) {
                            loadUserList();
                        }
                        console.log('data = ', data);
                    },
                    error: function(xhr, status, error) {
                        alert("Error occurred: " + error);
                    }
                });
            }
        });

        $("#submitForm").click(function() {
            $("#myForm").submit();
        });

        $("#listForm").click(function() {
            loadUserList();
        });

        function loadUserList() {
            console.log('Loading user list...');
            $('#result').html('<p>Loading...</p>');
            
            $.ajax({
                url: 'submit.cfc?method=giveall',
                type: 'GET',
                success: function(response) {
                    console.log('Raw response:', response);
                    
                    try {
                        var data = typeof response === 'string' ? JSON.parse(response) : response;
                        console.log('Parsed data:', data);
                        
                        if (data && Array.isArray(data) && data.length > 0) {
                            var resultHtml = '<h3>User List</h3>';
                            resultHtml += '<table>';
                            resultHtml += '<tr><th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Action</th></tr>';
                            
                            $.each(data, function(index, value) {
                                resultHtml += '<tr>';
                                resultHtml += '<td>' + value.user_id + '</td>';
                                resultHtml += '<td>' + value.name + '</td>';
                                resultHtml += '<td>' + value.email + '</td>';
                                resultHtml += '<td>' + value.phone + '</td>';
                                resultHtml += '<td><button class="delete-btn" data-userid="' + value.user_id + '">Delete</button></td>';
                                resultHtml += '</tr>';
                            });
                            resultHtml += '</table>';
                            $('#result').html(resultHtml);
                        } else if (data && data.error) {
                            $('#result').html('<p class="error">Error: ' + data.error + '</p>');
                        } else {
                            $('#result').html('<p>No users found in the database.</p>');
                        }
                    } catch (e) {
                        console.log('JSON parse error:', e);
                        $('#result').html('<p class="error">Error parsing response: ' + e.message + '</p>');
                    }
                },
                error: function(xhr, status, error) {
                    $('#result').html('<p class="error">Error loading data: ' + error + '</p>');
                }
            });
        }

        $(document).on('click', '.delete-btn', function() {
            var userId = $(this).data('userid');
            var userName = $(this).closest('tr').find('td:nth-child(2)').text();
            
            if (confirm('Are you sure you want to delete user "' + userName + '"?')) {
                $.ajax({
                    url: 'submit.cfc?method=deleteUser',
                    type: 'POST',
                    data: { user_id: userId },
                    success: function(response) {
                        console.log('Delete response:', response);
                        alert('User deleted successfully');
                        loadUserList();
                    },
                    error: function(xhr, status, error) {
                        alert('Error deleting user: ' + error);
                    }
                });
            }
        });
    });
    </script>
</head>
<body>
    <h2>Submit Your Details</h2>
    <form id="myForm">
        <input type="hidden" id="user_id" name="user_id" value="-1">
        
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" placeholder="Alice"><br><br>
        
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" placeholder="name@example.info"><br><br>
        
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" placeholder="Admin@123"><br><br>
        
        <label for="phone">Phone Number:</label>
        <input type="number" id="phone" name="phone" placeholder="9876543210"><br><br>
        
        <button type="button" id="submitForm">Submit</button>
        <button type="button" id="listForm">List</button>
    </form>
    
    <div id="result"></div>
</body>
</html>


<!--- 

<!DOCTYPE html>
<html>
<head>
    <title>Dynamic Dropdown with AJAX</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
    $(document).ready(function() {
        $('#fetchOptions').click(function() {
            $.ajax({
                url: 'options.cfc?method=getOptions',
                type: 'GET',
                dataType: 'json',
                success: function(data) {
                    var options = '';
                    $.each(data, function(index, value) {
                        options += '<option value="' + value.id + '">' + value.name + '</option>';
                    });
                    $('#options').html(options);
                },
                error: function(xhr, status, error) {
                    $('#options').html('<option value="">Error: ' + error + '</option>');
                }
            });
        });
    });
    </script>
</head>
<body>
    <button id="fetchOptions">Fetch Options</button>
    <select id="options"></select>
</body>
</html>


--->