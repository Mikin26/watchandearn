class update {
 String  id = "";
 String AppVersion = "";
 update({
   this.id = "",
   this.AppVersion = ""
});
 Map<String, dynamic> toJson() {
   return {
     'id': id,
     'AppVersion': AppVersion
   };
 }
}