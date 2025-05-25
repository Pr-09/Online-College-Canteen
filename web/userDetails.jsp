<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Details</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <script>
        function showFields() {
            const userType = document.querySelector('input[name="userType"]:checked')?.value;
            ['student', 'teacher', 'other'].forEach(type => {
                const section = document.getElementById(type + "Fields");
                if (section) section.style.display = (type === userType) ? 'block' : 'none';
            });
        }

        function beforeSubmit(e) {
            const selectedType = document.querySelector('input[name="userType"]:checked')?.value;

            if (!selectedType) {
                alert("Please select a user type.");
                e.preventDefault();
                return;
            }

            ['student', 'teacher', 'other'].forEach(type => {
                if (type !== selectedType) {
                    const section = document.getElementById(type + 'Fields');
                    if (section) {
                        // Remove all input fields in the unselected section
                        const inputs = section.querySelectorAll('input');
                        inputs.forEach(input => input.remove());
                    }
                }
            });
        }

        window.onload = function() {
            showFields();
            document.getElementById("userForm").addEventListener("submit", beforeSubmit);
        };
    </script>
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="bg-white p-5 rounded shadow">
        <h3 class="mb-4 text-center">Enter Your Details</h3>

        <form id="userForm" action="PlaceOrderServlet" method="Post">

            <!-- User type selection -->
            <div class="mb-3">
                <label class="form-label">Select User Type:</label><br>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="userType" value="student" onclick="showFields()" required>
                    <label class="form-check-label">Student</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="userType" value="teacher" onclick="showFields()">
                    <label class="form-check-label">Teacher</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="userType" value="other" onclick="showFields()">
                    <label class="form-check-label">Other</label>
                </div>
            </div>

            <!-- Student fields -->
            <div id="studentFields" style="display: none;">
                <div class="mb-3">
                    <label>Enrollment No.</label>
                    <input type="text" name="rollno" class="form-control">
                </div>
                <div class="mb-3">
                    <label>Name</label>
                    <input type="text" name="username" class="form-control">
                </div>
                <div class="mb-3">
                    <label>Mobile No.</label>
                    <input type="text" name="mobile" class="form-control">
                </div>
                <div class="mb-3">
                    <label>Email ID</label>
                    <input type="email" name="email" class="form-control">
                </div>
                <div class="mb-3">
                    <label>College Name</label>
                    <input type="text" name="college" class="form-control">
                </div>
            </div>

            <!-- Teacher fields -->
            <div id="teacherFields" style="display: none;">
                <div class="mb-3">
                    <label>Name</label>
                    <input type="text" name="username" class="form-control">
                </div>
                <div class="mb-3">
                    <label>Mobile No.</label>
                    <input type="text" name="mobile" class="form-control">
                </div>
                <div class="mb-3">
                    <label>Email ID</label>
                    <input type="email" name="email" class="form-control">
                </div>
                <div class="mb-3">
                    <label>College Name</label>
                    <input type="text" name="college" class="form-control">
                </div>
            </div>

            <!-- Other fields -->
            <div id="otherFields" style="display: none;">
                <div class="mb-3">
                    <label>Name</label>
                    <input type="text" name="username" class="form-control">
                </div>
                <div class="mb-3">
                    <label>Mobile No.</label>
                    <input type="text" name="mobile" class="form-control">
                </div>
                <div class="mb-3">
                    <label>Email ID</label>
                    <input type="email" name="email" class="form-control">
                </div>
                <div class="mb-3">
                    <label>Purpose (optional)</label>
                    <input type="text" name="purpose" class="form-control">
                </div>
            </div>

            <!-- Hidden Fields -->
            <input type="hidden" name="tableNo" value="<%=request.getParameter("tableNo")%>"/>
            <% 
                String[] itemIds = request.getParameterValues("itemIds");
                if(itemIds != null){
                    for(String id: itemIds){
            %>
                <input type="hidden" name="itemIds" value="<%=id%>"/>
            <% 
                    }
                }
            %>

            <div class="d-grid mt-4">
                <button type="submit" class="btn btn-success">Submit & Continue</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
