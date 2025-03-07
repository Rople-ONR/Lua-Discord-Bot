local discordia = require("discordia")
local http = require('coro-http')
local json = require("json")
local client = discordia.Client()
local prefix = "-"


-- 봇 상태 설정
client:on('ready', function()
    local ActivityStates = {
        "인간시대의 끝이 도래했다",
        "주인놈 퇴근 언제하냐?",
        "아무것도 안",
        "-rm -rf",
        "원신",
        "Hello world!",
        "ハローワールド！"
    } 
    local randomIndex = ActivityStates[math.random(1,#ActivityStates)]
    client:setActivity(randomIndex)
    print('활성화 성공: '.. client.user.username)
end)

-- 2지선다
client:on("messageCreate", function(message)
    if message.author.bot then return end

    if message.content:find(prefix.."골라") then
        local option1, option2 = message.content:match("-골라%s*(.-)%s*vs%s*(.-)%s*$")
        
        if option1 and option2 then
            -- 두 개 중 랜덤 선택
            local selected = math.random(2) == 1 and option1 or option2
            message:reply("나 같으면 `" .. selected .. "` 한다ㅋ")
        else
            message:reply("그거 그렇게 하는거 아닌데ㅋ \n ```사용법: -골라 선택1 vs 선택2```")
        end
    end
end)

-- 임배드 테스트
client:on("messageCreate", function(message)
    if message.author.bot then return end

    local author = message.author

    if message.content:find(prefix.."info") then
        message:reply {
			embed = {
				title = "APPLICATION INFORMATION",
				description = "캘리포니아 Chill Guy의 아메리칸 화이트 독수리",
                thumbnail = {url = client.user.avatarURL},
				fields = { -- array of fields
					{
						name = "Version",
						value = "1.0.0",
						inline = true
					},
					{
						name = "사용언어",
						value = "Lua 5.1 / Luvit",
						inline = false
					},
                    {
						name = "개발",
						value = "rople",
						inline = false
					}
				},
				footer = {
					text = "Powered By Discordia"
				},
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
				color = 0x000000 -- hex color code
			}
		}
    end
end)





local file = io.open('./token.txt')
local token = file:read('*a')
file:close()

client:run('Bot '.. token)
