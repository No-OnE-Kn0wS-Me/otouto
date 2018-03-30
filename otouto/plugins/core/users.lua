--[[
    users.lua
    Stores usernames, IDs, and display names for users seen by the bot.
    Worthless on its own but prerequisite for some plugins.

    Copyright 2016 topkecleon <drew@otou.to>
    This code is licensed under the GNU AGPLv3. See /LICENSE for details.
]]--

local users = {}

function users:init(bot)
    self.triggers = { '' }
    bot.database.users = bot.database.users or {}
    bot.database.users[tostring(bot.info.id)] = bot.info
end

function users:action(bot, msg)
    bot.database.users[tostring(msg.from.id)] = msg.from
    if msg.reply_to_message then
        bot.database.users[tostring(msg.reply_to_message.from.id)] = msg.reply_to_message.from
    elseif msg.forward_from then
        bot.database.users[tostring(msg.forward_from.id)] = msg.forward_from
    elseif msg.new_chat_member then
        bot.database.users[tostring(msg.new_chat_member.id)] = msg.new_chat_member
    elseif msg.left_chat_member then
        bot.database.users[tostring(msg.left_chat_member.id)] = msg.left_chat_member
    end
    return true
end

return users