/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import models.User;

/**
 *
 * @author Son Duong This program use filter to authorize page following roles
 */
@WebFilter(filterName = "AuthorizationFilter", urlPatterns = {"/*"})
public class AuthorizationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Get session
        HttpSession session = httpRequest.getSession(false);

        // Get user in session
        User user = (session != null) ? (User) session.getAttribute("USER") : null;
        String userRole = user == null ? null : user.getRole();

        // Get url that actor want to redirect
        String requestURI = httpRequest.getRequestURI();

        // Authorize page following roles 
        if (requestURI.contains("admin")) {
            // Chỉ cho phép người dùng có vai trò là "ADMIN" truy cập trang /admin
//            if (userRole != null && userRole.equals("ADMIN")) {
            if (true) {
                // Users with access
                chain.doFilter(request, response);
            } else {
                //  User is not allowed access page, redirect to error page
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/fail-authorization");
            }
        } else {
            // If page is not authorization require => allow user access
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        // Giải phóng tài nguyên của filter (nếu có)
    }

}
