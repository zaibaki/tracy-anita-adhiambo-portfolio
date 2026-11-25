(function(){
  var ham = document.getElementById("hamburger");
  if (ham) {
    ham.addEventListener("click", function(){
      var m = document.getElementById("mobileMenu");
      var open = m.classList.toggle("open");
      this.setAttribute("aria-expanded", open ? "true" : "false");
    });
  }
  var form = document.getElementById("msgForm");
  if (form) {
    form.addEventListener("submit", function(e){
      e.preventDefault();
      var name = document.getElementById("f-name").value.trim();
      var email = document.getElementById("f-email").value.trim();
      var msg = document.getElementById("f-msg").value.trim();
      var subject = encodeURIComponent("Portfolio message from " + name);
      var body = encodeURIComponent(msg + "\n\n- " + name + " (" + email + ")");
      window.location.href = "mailto:anita.tracy856@gmail.com?subject=" + subject + "&body=" + body;
    });
  }
  var dl = document.getElementById("downloadResume");
  if (dl) {
    dl.addEventListener("click", function(){
      var text = [
        "TRACY ANITA ADHIAMBO",
        "Nairobi, Kenya | anita.tracy856@gmail.com",
        "",
        "CAREER OBJECTIVES",
        "A motivated and enthusiastic student with a strong academic background and an interest in practical learning. Possesses good communication, teamwork, and organizational skills, and gains valuable professional experience.",
        "",
        "EDUCATION",
        "BSc Applied Biology (Expected 2025-2029) - Jomo Kenyatta University of Agriculture and Technology",
        "Kenya Certificate of Secondary Education (KCSE) 2021-2024 - Moi Suba Girls High School",
        "",
        "CORE SKILLS",
        "Practical & Personal: Communication Skills, Teamwork and Collaboration, Time Management, Problem-solving, Attention to Detail",
        "Computer: Microsoft Word, Microsoft Excel, PowerPoint, Data Entry, Report Writing",
        "",
        "FIELD AND PROJECT EXPERIENCE",
        "- Academic and laboratory practical work.",
        "- Participated in academic practical activities and laboratory exercises.",
        "- Followed instructions and maintained accuracy during assigned tasks.",
        "- Prepared academic reports and documented practical findings.",
        "",
        "ICS 2216 Applied Computing, JKUAT"
      ].join("\n");
      var blob = new Blob([text], {type:"text/plain"});
      var url = URL.createObjectURL(blob);
      var a = document.createElement("a");
      a.href = url; a.download = "Tracy-Anita-Adhiambo-Resume.txt";
      document.body.appendChild(a); a.click(); a.remove();
      setTimeout(function(){ URL.revokeObjectURL(url); }, 2000);
    });
  }
})();
