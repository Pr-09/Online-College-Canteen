<%@ page import="java.sql.*, java.util.*, dao.DBConnection" %>
<%
    String tableNo = request.getParameter("tableNo");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Menu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #121212;
            color: #fff;
        }

        .category-btn.active {
            background-color: #1e3c72;
            color: white;
        }

        .category-btn {
            color: #fff;
            border-color: #2a5298;
            transition: all 0.3s ease;
        }

        .category-btn:hover {
            background-color: #2a5298;
            color: #fff;
        }

        .card-img-placeholder {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 200px;
            background-color: #2a2a2a;
            color: #ccc;
            font-style: italic;
        }

        .sticky-header {
            position: sticky;
            top: 60px;
            z-index: 1040;
            background: #121212;
            padding: 1rem 0;
        }

        .custom-scrollbar {
            overflow-x: auto;
            white-space: nowrap;
        }

        .custom-scrollbar .btn {
            display: inline-block;
        }

        .form-check-input:checked {
            background-color: #1e3c72;
            border-color: #2a5298;
        }

        .form-check-label {
            color: #ccc;
            transition: all 0.2s ease-in-out;
        }

        .form-check-input:checked + .form-check-label {
            color: #fff;
            font-weight: 500;
        }

        .btn-continue {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            color: #fff;
            border: none;
            padding: 0.6rem 1.5rem;
            font-size: 1rem;
            border-radius: 8px;
            transition: all 0.3s ease;
            position: sticky;
            bottom: 20px;
            z-index: 1050;
        }

        .btn-continue:hover {
            transform: scale(1.05);
            background: linear-gradient(135deg, #2a5298, #1e3c72);
        }

        .card:hover {
            transform: scale(1.02);
            box-shadow: 0 8px 16px rgba(255, 255, 255, 0.1);
            transition: all 0.3s ease-in-out;
        }

        .form-check-label:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="container mt-5" style="padding-top: 80px;">
    <h2 class="text-center mb-4">Select Table & Menu Items</h2>
    <form action="userDetails.jsp" method="post">

        <!-- Sticky Section: Table Selector + Search + Categories -->
        <div class="sticky-header">
            <div class="row justify-content-center align-items-center mb-3">
                <label for="tableNo" class="col-sm-2 col-form-label text-end">Table No:</label>
                <div class="col-sm-2">
                    <select id="tableNo" name="tableNo" class="form-select" required>
                        <option value="" disabled <%= tableNo == null ? "selected" : "" %>>Choose?</option>
                        <% for (int i = 1; i <= 7; i++) { %>
                        <option value="<%= i %>" <%= String.valueOf(i).equals(tableNo) ? "selected" : "" %>>
                            <%= i %>
                        </option>
                        <% } %>
                    </select>
                </div>
                <div class="col-md-4">
                    <input type="text" id="searchInput" class="form-control" placeholder="Search by name or category..." onkeyup="searchMenu()">
                </div>
            </div>

            <!-- Category Buttons -->
            <div class="custom-scrollbar text-center pb-2">
                <div id="categoryButtons">
                    <% 
                        Set<String> categories = new LinkedHashSet<>();
                        try (Connection conn = DBConnection.getConnection();
                             Statement stmt = conn.createStatement();
                             ResultSet rs = stmt.executeQuery("SELECT DISTINCT type_of_food FROM menu_items")) {
                            while (rs.next()) {
                                categories.add(rs.getString("type_of_food"));
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                        for (String category : categories) {
                    %>
                        <button type="button" class="btn btn-outline-light m-1 category-btn" onclick="filterCategory('<%= category %>')">
                            <%= category %>
                        </button>
                    <% } %>
                </div>
            </div>
        </div>

        <!-- Menu Items -->
        <div class="row" id="menuContainer">
            <%
                List<Map<String, String>> menuItems = new ArrayList<>();
                try (Connection conn = DBConnection.getConnection();
                     Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery("SELECT * FROM menu_items")) {
                    while (rs.next()) {
                        Map<String, String> item = new HashMap<>();
                        item.put("id", String.valueOf(rs.getInt("id")));
                        item.put("name", rs.getString("name"));
                        item.put("desc", rs.getString("description"));
                        item.put("price", String.valueOf(rs.getDouble("price")));
                        item.put("type", rs.getString("type_of_food"));
                        item.put("image", rs.getString("image_path"));
                        menuItems.add(item);
                    }

                    for (Map<String, String> item : menuItems) {
            %>
            <div class="col-md-4 mb-3 menu-item" data-type="<%= item.get("type") %>" data-name="<%= item.get("name").toLowerCase() %>">
                <div class="card h-100 shadow-sm bg-dark text-white">
                    <% if (item.get("image") != null && !item.get("image").trim().isEmpty()) { %>
                        <img src="<%= item.get("image") %>" class="card-img-top" alt="<%= item.get("name") %>" style="height: 200px; object-fit: cover;">
                    <% } else { %>
                        <div class="card-img-placeholder">Food image is not present</div>
                    <% } %>
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title"><%= item.get("name") %></h5>
                        <p class="card-text flex-grow-1"><%= item.get("desc") %></p>
                        <p class="mb-2"><strong>Rs <%= item.get("price") %></strong></p>
                        <div class="form-check mt-auto">
                            <input class="form-check-input" type="checkbox" name="itemIds" value="<%= item.get("id") %>" id="item<%= item.get("id") %>">
                            <label class="form-check-label" for="item<%= item.get("id") %>">Add to order</label>
                        </div>
                    </div>
                </div>
            </div>
            <%  }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </div>

        <!-- Submit Button -->
        <div class="d-flex justify-content-center mt-4">
            <button type="submit" class="btn btn-continue">Continue to Details</button>
        </div>
    </form>
</div>
<%@ include file="footer.jsp" %>

<!-- Scripts -->
<script>
    function filterCategory(category) {
        const items = Array.from(document.querySelectorAll('.menu-item'));
        items.forEach(item => {
            item.style.display = item.dataset.type === category ? 'block' : 'none';
        });

        document.querySelectorAll('.category-btn').forEach(btn => btn.classList.remove('active'));
        [...document.querySelectorAll('.category-btn')].find(btn => btn.textContent.trim() === category)?.classList.add('active');
        document.getElementById('searchInput').value = '';
    }

    function searchMenu() {
        const query = document.getElementById('searchInput').value.toLowerCase();
        const items = document.querySelectorAll('.menu-item');

        items.forEach(item => {
            const name = item.dataset.name;
            const type = item.dataset.type.toLowerCase();
            item.style.display = (name.includes(query) || type.includes(query)) ? 'block' : 'none';
        });

        document.querySelectorAll('.category-btn').forEach(btn => btn.classList.remove('active'));
    }
</script>
</body>
</html>



<%--

<%@ page import="java.sql.*, java.util.*, dao.DBConnection" %>
<%
    String tableNo = request.getParameter("tableNo");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Menu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .category-btn.active {
            background-color: #198754;
            color: white;
        }
        .card-img-placeholder {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 200px;
            background-color: #f0f0f0;
            color: #999;
            font-style: italic;
        }
    </style>
</head>
<body class="bg-light">
<%@ include file="navbar.jsp" %>
<div class="container mt-5" style="padding-top: 80px;">
    <h2 class="text-center mb-4">Select Table & Menu Items</h2>
    <form action="userDetails.jsp" method="post">

        <!-- Table Selector -->
        <div class="mb-4 row justify-content-center">
            <label for="tableNo" class="col-sm-2 col-form-label text-end">Table No:</label>
            <div class="col-sm-2">
                <select id="tableNo" name="tableNo" class="form-select" required>
                    <option value="" disabled <%= tableNo == null ? "selected" : "" %>>Choose?</option>
                    <% for (int i = 1; i <= 7; i++) { %>
                        <option value="<%= i %>" <%= String.valueOf(i).equals(tableNo) ? "selected" : "" %>>
                            <%= i %>
                        </option>
                    <% } %>
                </select>
            </div>
        </div>

        <!-- Search Bar -->
        <div class="mb-4 row justify-content-center">
            <div class="col-md-6">
                <input type="text" id="searchInput" class="form-control" placeholder="Search by name or category..." onkeyup="searchMenu()">
            </div>
        </div>

        <!-- Category Buttons -->
        <div class="mb-4 text-center">
            <%
                Set<String> categories = new LinkedHashSet<>();
                try (Connection conn = DBConnection.getConnection();
                     Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery("SELECT DISTINCT type_of_food FROM menu_items")) {
                    while (rs.next()) {
                        categories.add(rs.getString("type_of_food"));
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }

                for (String category : categories) {
            %>
                <button type="button" class="btn btn-outline-success m-1 category-btn" onclick="filterCategory('<%= category %>')">
                    <%= category %>
                </button>
            <% } %>
        </div>

        <!-- Menu Items -->
        <div class="row" id="menuContainer">
            <%
                List<Map<String, String>> menuItems = new ArrayList<>();
                try (Connection conn = DBConnection.getConnection();
                     Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery("SELECT * FROM menu_items")) {
                    while (rs.next()) {
                        Map<String, String> item = new HashMap<>();
                        item.put("id", String.valueOf(rs.getInt("id")));
                        item.put("name", rs.getString("name"));
                        item.put("desc", rs.getString("description"));
                        item.put("price", String.valueOf(rs.getDouble("price")));
                        item.put("type", rs.getString("type_of_food"));
                        item.put("image", rs.getString("image_path"));
                        menuItems.add(item);
                    }

                    for (Map<String, String> item : menuItems) {
            %>
            <div class="col-md-4 mb-3 menu-item" data-type="<%= item.get("type") %>" data-name="<%= item.get("name").toLowerCase() %>">
                <div class="card h-100 shadow-sm">
                    <% if (item.get("image") != null && !item.get("image").trim().isEmpty()) { %>
                        <img src="<%= item.get("image") %>" class="card-img-top" alt="<%= item.get("name") %>" style="height: 200px; object-fit: cover;">
                    <% } else { %>
                        <div class="card-img-placeholder">Food image is not present</div>
                    <% } %>
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title"><%= item.get("name") %></h5>
                        <p class="card-text flex-grow-1"><%= item.get("desc") %></p>
                        <p class="mb-2"><strong>Rs <%= item.get("price") %></strong></p>
                        <div class="form-check mt-auto">
                            <input class="form-check-input" type="checkbox" name="itemIds" value="<%= item.get("id") %>" id="item<%= item.get("id") %>">
                            <label class="form-check-label" for="item<%= item.get("id") %>">Add to order</label>
                        </div>
                    </div>
                </div>
            </div>
            <%  }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </div>

        <!-- Submit Button -->
        <div class="d-grid mt-4">
            <button type="submit" class="btn btn-success btn-lg">Continue to Details</button>
        </div>
    </form>
</div>
<%@ include file="footer.jsp" %>

<!-- Scripts -->
<script>
    function filterCategory(category) {
        const items = Array.from(document.querySelectorAll('.menu-item'));
        const filtered = items.filter(item => item.dataset.type === category);
        const others = items.filter(item => item.dataset.type !== category);

        const container = document.getElementById('menuContainer');
        container.innerHTML = '';

        filtered.forEach(item => container.appendChild(item));
        others.forEach(item => container.appendChild(item));

        document.querySelectorAll('.category-btn').forEach(btn => btn.classList.remove('active'));
        [...document.querySelectorAll('.category-btn')].find(btn => btn.textContent.trim() === category)?.classList.add('active');

        document.getElementById('searchInput').value = ''; // clear search
    }

    function searchMenu() {
        const query = document.getElementById('searchInput').value.toLowerCase();
        const items = document.querySelectorAll('.menu-item');

        items.forEach(item => {
            const name = item.dataset.name;
            const type = item.dataset.type.toLowerCase();
            if (name.includes(query) || type.includes(query)) {
                item.style.display = 'block';
            } else {
                item.style.display = 'none';
            }
        });

        document.querySelectorAll('.category-btn').forEach(btn => btn.classList.remove('active')); // clear category highlight
    }
</script>
</body>
</html>


--%>