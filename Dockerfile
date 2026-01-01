# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
RUN comfy node install --exit-on-fail comfyui-impact-subpack@1.3.5 --mode remote
RUN comfy node install --exit-on-fail comfyui-impact-pack@8.28.1
RUN comfy node install --exit-on-fail rgthree-comfy@1.0.2512112053
RUN comfy node install --exit-on-fail comfyui_essentials@1.1.0
# The following custom nodes are in an unknown registry and do not provide aux_id (GitHub repo), so they could not be automatically resolved or installed:
# - unknown_registry nodes: Note, PrimitiveNode (skipped - no aux_id available)

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Bingsu/adetailer/resolve/main/face_yolov8m.pt --relative-path models/ultralytics/bbox --filename face_yolov8m.pt
RUN comfy model download --url https://dl.fbaipublicfiles.com/segment_anything/sam_vit_b_01ec64.pth --relative-path models/sams --filename sam_vit_b_01ec64.pth
RUN comfy model download --url https://huggingface.co/gbrx/GonzaLomo/blob/main/gonzalomoXLFluxPony_v40UnityXLDMD.safetensors --relative-path models/checkpoints --filename gonzalomoXLFluxPony_v40UnityXLDMD.safetensors
# RUN # Could not find URL for gonzalomoXLFluxPony_v10FluxSAIO.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
