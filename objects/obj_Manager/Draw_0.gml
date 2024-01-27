/// obj_Manager : Draw

update_and_render_particles();


// testing: draw enemy items
addFpsAvg(fps_real);

draw_text(8, room_height - 28, $"Level {level}");
//draw_text(8, room_height - 14, $"Inst #: {instance_count}  FPS: {calculateFpsAvg()}");