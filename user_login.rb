#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

class UserLogin
  USERS = {
    'admin' => 'admin123',
    'eda' => 'password',
    'user' => '12345'
  }

  def self.start
    puts "=" * 40
    puts "   KULLANICI GİRİŞ SİSTEMİ"
    puts "=" * 40
    puts

    loop do
      print "Kullanıcı adı: "
      username = gets.chomp.strip

      if username.empty?
        puts "Kullanıcı adı boş olamaz!"
        next
      end

      print "Şifre: "
      password = gets.chomp.strip

      if password.empty?
        puts "Şifre boş olamaz!"
        next
      end

      if authenticate(username, password)
        puts
        puts "Giriş başarılı! Hoş geldiniz, #{username}!"
        puts "Sisteme başarıyla giriş yaptınız."
        break
      else
        puts
        puts "Hatalı kullanıcı adı veya şifre!"
        puts "Tekrar deneyin veya 'q' yazarak çıkın."
        
        print "Devam etmek istiyor musunuz? (e/h): "
        choice = gets.chomp.downcase
        
        if choice == 'h' || choice == 'hayır' || choice == 'q'
          puts "Görüşürüz!"
          break
        end
        
        puts
      end
    end
  end

  private

  def self.authenticate(username, password)
    USERS[username] == password
  end
end

if __FILE__ == $0
  puts "Kullanıcı giriş sistemi başlatılıyor..."
  puts
  UserLogin.start
end
