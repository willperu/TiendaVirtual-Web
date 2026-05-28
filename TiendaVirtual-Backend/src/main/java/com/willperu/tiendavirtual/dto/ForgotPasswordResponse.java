package com.willperu.tiendavirtual.dto;

public class ForgotPasswordResponse {
    private String token;
    private String verificationCode;

    public ForgotPasswordResponse(String token, String verificationCode) {
        this.token = token;
        this.verificationCode = verificationCode;
    }

    // getters

    public String getToken() {
        return token;
    }

    public String getVerificationCode() {
        return verificationCode;
    }
    
}
