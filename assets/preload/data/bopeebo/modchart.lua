




function start (song)
    -- happens when the song starts
 end
 function update (elapsed)
    -- happens at every rendered frame
 end
 function beatHit (beat)
    -- happens 4 times a section
 end
 
 function bumpArrows()

    setActorX(xTo4, 4)
    tweenPos(4,xTo4 + 120,getActorY(4),0.5)
    setActorX(xTo5, 5)
    tweenPos(5,xTo5 + 60,getActorY(5),0.5)

    setActorX(xTo6, 6)
    tweenPos(6,xTo6 - 60,getActorY(6),0.5)
    setActorX(xTo7, 7)
    tweenPos(7,xTo7 - 120, getActorY(7),0.5)
end

 function stepHit (step)
    -- happens 16 times a section
    if curStep == 10 then
        bumpArrows()
    end
 end


