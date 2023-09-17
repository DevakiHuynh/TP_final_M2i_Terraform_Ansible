#Mise en utilisation de key_pair

resource "aws_key_pair" "deployer" {
  key_name = "dev_accesskey"
  public_key = file("C:\\Users\\chiri\\Desktop\\TP_M2i\\Devaki_accessKeys.csv")
}
