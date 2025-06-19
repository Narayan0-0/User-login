component {
    remote function insertdb() output = "false" returnType = "string" returnFormat = "JSON" {
        try {
            if (arguments.user_id == -1) {
                queryExecute(
                    "INSERT INTO valid_users (name, email, password, phone) VALUES (?, ?, ?, ?)",
                    [arguments.name, arguments.email, arguments.password, arguments.phone],
                    { datasource = "mydb" }
                );
                return serializeJSON({"success": true, "message": "User Created Successfully"});
            } else {
                queryExecute(
                    "UPDATE valid_users SET name = ?, email = ?, password = ?, phone = ? WHERE user_id = ?",
                    [arguments.name, arguments.email, arguments.password, arguments.phone, arguments.user_id],
                    { datasource = "mydb" }
                );
                return serializeJSON({"success": true, "message": "User Updated Successfully"});
            }
        } catch (any e) {
            writeLog(file="application", text="Error in insertdb: #e.message#", type="error");
            return serializeJSON({"success": false, "message": "An error occurred: #e.message#"});
        }
    }

    remote function giveall() output = "false" returnType = "string" returnFormat = "JSON" {
        try {
            var result = queryExecute(
                "SELECT user_id, name, email, phone FROM valid_users ORDER BY user_id",
                [],
                { datasource = "mydb" }
            );
            
            var users = [];
            for (row in result) {
                arrayAppend(users, {
                    "user_id": row.user_id,
                    "name": row.name,
                    "email": row.email,
                    "phone": row.phone
                });
            }
            
            return serializeJSON(users);
        } catch (any e) {
            writeLog(file="application", text="Error in giveall: #e.message#", type="error");
            return serializeJSON([{"error": "An error occurred: #e.message#"}]);
        }
    }

    remote function deleteUser() output = "false" returnType = "string" returnFormat = "JSON" {
        // if(cgi.REQUEST_METHOD != 'delete'){
            // return serializeJSON({"success": false, "message": "Method Not Supported"});
        // }
        try {
            var result = queryExecute(
                "DELETE FROM valid_users WHERE user_id = ?",
                [arguments.user_id],
                { datasource = "mydb" }
            );
            
            return serializeJSON({"success": true, "message": "User deleted successfully"});
        } catch (any e) {
            writeLog(file="application", text="Error in deleteUser: #e.message#", type="error");
            return serializeJSON({"success": false, "message": "Error deleting user: #e.message#"});
        }
    }
}