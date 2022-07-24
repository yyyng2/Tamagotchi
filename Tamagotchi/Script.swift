//
//  Script.swift
//  Tamagotchi
//
//  Created by Y on 2022/07/22.
//

import Foundation

struct Script{
    let scriptType: [String]
}

struct ScriptType{
    let scripts: [Script] = [
        Script(scriptType: ["뭐", "왜", "그래서?", "어쩌자고?", "조용해", "건들지마", "말걸지마", "뭘 봐", "네 할일이나 해", "배고파", "밥줘", "배불러", "코드 안치냐?"]),
        Script(scriptType: ["안녕하세요", "반가워요", "식사는 하셨나요?", "날씨가 좋죠?", "깃허브 푸쉬하셨나요?", "여기 좀 봐주세요", "하루가 어땠나요?", "물 좀 주실 수 있나요?", "밥 시간인 것 같아요!", "배가 부르네요!", "복습하셨나요?"]),        
        Script(scriptType: ["...", "..?..", "카우닝..스딸~! 밤하늘의,, 퍼얼", "..저기..", "빛나는 별이 될거야..", "..ㅂ..밥 좀", "저..ㅁ..물..좀..", "...코드..짜셔야.."])
    ]
}
