# FLASH HUB — Mobile Edition v1.2.1

ใช้ภาพที่ผู้ใช้ส่งล่าสุดเป็นโลโก้หลักของ FLASH HUB โดยตรง

## ไฟล์
- `FLASHHUB.lua` — โค้ด Mobile Edition ชื่อ FLASH HUB
- `FLASH_HUB_LOGO.png` — โลโก้ภาพล่าสุดที่ผู้ใช้ส่ง
- `README.md` — คู่มือ

## แสดงโลโก้ใน Roblox
โค้ดใช้ `LOGO_IMAGE = "rbxassetid://0"` เป็นค่าเริ่มต้น:
1. อัปโหลด `FLASH_HUB_LOGO.png` ใน Creator Dashboard ของ Roblox เป็น Image/Decal
2. คัดลอก Asset ID
3. เปิด `FLASHHUB.lua` แล้วแทน `rbxassetid://0` ด้วย `rbxassetid://หมายเลขของคุณ`

จนกว่าจะใส่ Asset ID จริง โลโก้จะยังไม่แสดงใน UI แม้ไฟล์ภาพจะอยู่ในแพ็กเกจแล้ว

## ทดสอบ
แนะนำให้ทดสอบใน Roblox Studio ด้วย LocalScript ที่ `StarterPlayer > StarterPlayerScripts` ก่อน
Delta Executor เป็นเครื่องมือภายนอก ความเข้ากันได้ขึ้นอยู่กับเวอร์ชันและสภาพแวดล้อม

## ขอบเขต
เป็น Mobile UI starter แบบ read-only ไม่ใช่ตัวสแกนเกมสมบูรณ์ อ่านเฉพาะข้อมูล LocalPlayer ที่ Client มองเห็นได้ หากไม่มีจะแสดง N/A
หน้าเมนูอื่นยังเป็นโครง UI รอเชื่อมแหล่งข้อมูลจริง
