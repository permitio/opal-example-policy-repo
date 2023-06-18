permit(
    principal in SecurityGroup::"prodViewer",
    action in [
        Action::"prodRegService:list",
        Action::"prodRegService:get",
	],
    resource in ResourceType::"service"
);
